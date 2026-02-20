"""
SCAVENGED FROM: danielmiessler/fabric — internal/core/chatter.go + template/template.go
PURPOSE: Python translation of Fabric's multi-layer prompt orchestration pipeline
LICENSE: MIT

ARCHITECTURE (from Fabric's Go implementation):
    Context + Pattern + Strategy + Language → System Message
    User Input + Variables → Template Engine → Final Prompt
    Session Management → LLM Call → Post-Processing → Save

This is the PATTERN you need for building agentic trees in Python.
Fabric's key insight: prompts are composable, layered, and reusable.
"""

from __future__ import annotations
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterator


# ─── Pattern Registry (file-system based prompt templates) ───────────

@dataclass
class Pattern:
    """A reusable prompt template. Stored as system.md files on disk."""
    name: str
    system_prompt: str
    variables: list[str] = field(default_factory=list)

    @classmethod
    def load(cls, patterns_dir: Path, name: str) -> "Pattern":
        path = patterns_dir / name / "system.md"
        content = path.read_text()
        # Extract {{variable}} tokens
        variables = re.findall(r"\{\{(\w+)\}\}", content)
        return cls(name=name, system_prompt=content, variables=variables)

    def render(self, variables: dict[str, str], user_input: str = "") -> str:
        """Apply variable substitution to the template."""
        result = self.system_prompt
        for key, value in variables.items():
            result = result.replace(f"{{{{{key}}}}}", value)
        result = result.replace("{{input}}", user_input)
        return result


# ─── Strategy (meta-prompt that shapes how patterns execute) ─────────

@dataclass
class Strategy:
    """A reusable instruction layer prepended to any pattern."""
    name: str
    description: str
    prompt: str

    @classmethod
    def load(cls, strategies_dir: Path, name: str) -> "Strategy":
        path = strategies_dir / f"{name}.json"
        data = json.loads(path.read_text())
        return cls(**data)


# ─── Session (conversation state management) ────────────────────────

@dataclass
class Message:
    role: str      # "system" | "user" | "assistant"
    content: str

@dataclass
class Session:
    name: str = ""
    messages: list[Message] = field(default_factory=list)

    def append(self, role: str, content: str) -> None:
        self.messages.append(Message(role=role, content=content))

    def get_messages(self) -> list[dict[str, str]]:
        return [{"role": m.role, "content": m.content} for m in self.messages]

    def save(self, sessions_dir: Path) -> None:
        if self.name:
            path = sessions_dir / f"{self.name}.json"
            path.write_text(json.dumps(
                [{"role": m.role, "content": m.content} for m in self.messages],
                indent=2
            ))

    @classmethod
    def load(cls, sessions_dir: Path, name: str) -> "Session":
        path = sessions_dir / f"{name}.json"
        if not path.exists():
            return cls(name=name)
        data = json.loads(path.read_text())
        session = cls(name=name)
        session.messages = [Message(**m) for m in data]
        return session


# ─── Template Engine (variable + plugin substitution) ────────────────

class TemplateEngine:
    """
    Fabric's template system supports:
      {{variable}}              → simple substitution
      {{plugin:text:lowercase}} → plugin call
      {{input}}                 → user input injection
    """
    TOKEN_RE = re.compile(r"\{\{([^{}]+)\}\}")

    def apply(self, template: str, variables: dict[str, str], user_input: str = "") -> str:
        def replacer(match: re.Match) -> str:
            token = match.group(1)

            # Built-in: input
            if token == "input":
                return user_input

            # Plugin call: plugin:namespace:operation
            if token.startswith("plugin:"):
                parts = token.split(":")
                if len(parts) >= 3:
                    namespace, operation = parts[1], parts[2]
                    return self._run_plugin(namespace, operation, parts[3] if len(parts) > 3 else "")

            # Simple variable
            if token in variables:
                return variables[token]

            return match.group(0)  # Leave unresolved tokens as-is

        return self.TOKEN_RE.sub(replacer, template)

    @staticmethod
    def _run_plugin(namespace: str, operation: str, value: str) -> str:
        """Extend this with your own plugins."""
        if namespace == "text":
            if operation == "lowercase":
                return value.lower()
            if operation == "uppercase":
                return value.upper()
        if namespace == "datetime":
            from datetime import datetime
            if operation == "now":
                return datetime.now().isoformat()
        return f"[plugin:{namespace}:{operation} not found]"


# ─── Chat Request (the input to the pipeline) ───────────────────────

@dataclass
class ChatRequest:
    message: str                                     # User input
    pattern_name: str = ""                           # Which prompt template
    context_name: str = ""                           # Additional context
    session_name: str = ""                           # Resume conversation
    strategy_name: str = ""                          # Meta-prompt layer
    language: str = "en"                             # Output language
    variables: dict[str, str] = field(default_factory=dict)

@dataclass
class ChatOptions:
    model: str = "claude-sonnet-4-5-20250929"
    temperature: float = 0.7
    max_tokens: int = 4096
    stream: bool = True


# ─── The Pipeline (Fabric's core orchestration logic) ────────────────

class AgenticPipeline:
    """
    Fabric's orchestration pattern translated to Python.

    Pipeline:
      1. Load/resume session
      2. Compose system message: Strategy + Context + Pattern
      3. Apply variable substitution
      4. Send to LLM (streaming or batch)
      5. Post-process output
      6. Save session
    """

    def __init__(self, base_dir: Path):
        self.patterns_dir = base_dir / "patterns"
        self.strategies_dir = base_dir / "strategies"
        self.contexts_dir = base_dir / "contexts"
        self.sessions_dir = base_dir / "sessions"
        self.template_engine = TemplateEngine()

        # Ensure dirs exist
        for d in [self.patterns_dir, self.strategies_dir, self.contexts_dir, self.sessions_dir]:
            d.mkdir(parents=True, exist_ok=True)

    def build_session(self, request: ChatRequest) -> Session:
        """Compose the full message sequence."""
        # 1. Load or create session
        if request.session_name:
            session = Session.load(self.sessions_dir, request.session_name)
        else:
            session = Session()

        # 2. Build system message layers
        parts: list[str] = []

        # Layer 1: Strategy (meta-prompt)
        if request.strategy_name:
            strategy = Strategy.load(self.strategies_dir, request.strategy_name)
            parts.append(strategy.prompt)

        # Layer 2: Context
        if request.context_name:
            ctx_path = self.contexts_dir / f"{request.context_name}.md"
            if ctx_path.exists():
                parts.append(ctx_path.read_text().strip())

        # Layer 3: Pattern (main prompt template)
        if request.pattern_name:
            pattern = Pattern.load(self.patterns_dir, request.pattern_name)
            rendered = self.template_engine.apply(
                pattern.system_prompt, request.variables, request.message
            )
            parts.append(rendered)

        # Layer 4: Language instruction
        if request.language and request.language != "en":
            parts.append(
                f"\nIMPORTANT: Ensure your entire final response is written "
                f"ONLY in {request.language}."
            )

        # Combine into system message
        system_message = "\n\n".join(parts).strip()
        if system_message:
            session.append("system", system_message)

        # Add user message
        session.append("user", request.message)

        return session

    def execute(self, request: ChatRequest, options: ChatOptions, llm_callable=None) -> Session:
        """
        Full pipeline execution.

        llm_callable: A function that takes (messages: list[dict], options: ChatOptions)
                      and returns the assistant's response string.
        """
        session = self.build_session(request)

        if llm_callable is None:
            raise ValueError("Provide an llm_callable (e.g., anthropic/openai client wrapper)")

        # Send to LLM
        response = llm_callable(session.get_messages(), options)

        # Post-process
        response = self._post_process(response)

        # Append and save
        session.append("assistant", response)
        if request.session_name:
            session.name = request.session_name
            session.save(self.sessions_dir)

        return session

    @staticmethod
    def _post_process(response: str) -> str:
        """Strip thinking blocks and clean output."""
        # Remove <think>...</think> blocks if present
        response = re.sub(r"<think>.*?</think>", "", response, flags=re.DOTALL)
        return response.strip()


# ─── Usage Example ───────────────────────────────────────────────────

if __name__ == "__main__":
    # Setup
    pipeline = AgenticPipeline(base_dir=Path("./fabric_data"))

    # Create a pattern
    (pipeline.patterns_dir / "summarize" ).mkdir(exist_ok=True)
    (pipeline.patterns_dir / "summarize" / "system.md").write_text(
        "# IDENTITY\nYou are an expert summarizer.\n\n"
        "# OUTPUT\n- ONE SENTENCE SUMMARY: 20 words max\n- MAIN POINTS: 5 bullets\n\n"
        "# INPUT\nINPUT:"
    )

    # Build request
    request = ChatRequest(
        message="The quick brown fox jumped over the lazy dog...",
        pattern_name="summarize",
    )
    options = ChatOptions(model="claude-sonnet-4-5-20250929", temperature=0.3)

    # Execute (pass your own LLM client)
    # session = pipeline.execute(request, options, llm_callable=my_llm_call)

    # Preview what would be sent
    session = pipeline.build_session(request)
    for msg in session.get_messages():
        print(f"[{msg['role']}]")
        print(msg['content'][:200])
        print("---")
