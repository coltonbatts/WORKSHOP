# Agentic Pipeline Experiment

This folder contains a Python translation of the **Fabric** orchestration engine, designed for composable LLM workflows.

## Components

- `agentic_pipeline.py`: The core engine. Handles patterns, strategies, and session management.
- `patterns/`: Directory for prompt templates.
  - `extract_wisdom.md`: Fabric's flagship pattern for structured knowledge extraction.
  - `explain_code.md`: Context-aware code analysis.

## Usage

1. Initialize the pipeline with your patterns directory.
2. Load a pattern by name.
3. (Optional) Apply a strategy to shape the output style.
4. Run the pipeline with user input.

```python
from agentic_pipeline import Pipeline

pipeline = Pipeline(patterns_dir="./patterns")
result = pipeline.run(pattern="extract_wisdom", input_text="Your content here...", strategy="be_concise")
print(result)
```

## Future Work

- Add more patterns from the Fabric repository.
- Integrate with Anthropic/OpenAI SDKs directly.
- Add tool-calling capabilities to the strategies.
