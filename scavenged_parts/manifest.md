# Scavenged Parts Manifest

> Technical Scavenger Run — 2026-02-07
> Target Profile: Colton Batts (Lead Designer / Creative Developer)
> Filter: Ownership > Subscription | Educational Brutalism | Swift+Rust+Python Synergy

---

## Directory Structure

```
scavenged_parts/
├── manifest.md                          ← You are here
├── keyboard_shortcuts/
│   ├── GlobalHotkey.swift               ← ColorWizard global hotkey integration
│   └── CarbonHotkeyCore.swift           ← Low-level reference (Carbon API docs)
├── tweakpane/
│   └── brutalist-theme.css              ← Industrial UI design system
├── neo_brutalism/
│   ├── NBBoxModifier.swift              ← Core neo-brutalist view modifier
│   └── NBComponents.swift               ← Full component kit (Button/Card/Input/Slider)
└── fabric/
    ├── patterns/
    │   ├── extract_wisdom.md            ← Multi-section content extraction prompt
    │   └── explain_code.md              ← Code analysis prompt template
    └── orchestration/
        └── agentic_pipeline.py          ← Python translation of Fabric's LLM pipeline
```

---

## Part 1: `keyboard_shortcuts/GlobalHotkey.swift`

**Source:** [sindresorhus/KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts)
**License:** MIT

### What It Is
A ready-to-use integration guide for adding a global "Color Picker" hotkey to ColorWizard. Includes the `KeyboardShortcuts.Name` definition, three handler patterns (AppDelegate, SwiftUI `.task{}`, view modifier), a `Recorder` settings view, and menu bar shortcut display.

### Why It Was Chosen
- **Self-contained:** Zero external API dependencies. Uses macOS Carbon API under the hood — no subscription, no server calls.
- **SwiftUI-native:** The `Recorder` view drops directly into a settings form. The `.onGlobalKeyboardShortcut()` modifier is one line.
- **UserDefaults persistence:** Shortcut preferences survive app restarts with zero setup.

### How It Fits ColorWizard
1. Add `KeyboardShortcuts` via SPM: `https://github.com/sindresorhus/KeyboardShortcuts`
2. Define `.toggleColorPicker` name with default `Cmd+Shift+C`
3. Wire it to your color picker toggle logic
4. Add `ShortcutSettingsView` to your preferences window
5. Optionally show the shortcut in your menu bar extra with `.globalKeyboardShortcut()`

**The minimum viable integration is 3 lines of code.**

---

## Part 2: `keyboard_shortcuts/CarbonHotkeyCore.swift`

**Source:** sindresorhus/KeyboardShortcuts — CarbonKeyboardShortcuts.swift
**License:** MIT

### What It Is
Annotated documentation of the Carbon Event API plumbing that powers global hotkeys on macOS. Explains `RegisterEventHotKey()`, the event handler setup, and the NSMenu tracking workaround.

### Why It Was Chosen
Understanding the layer beneath the library. If you ever need to debug why a hotkey isn't firing (sandbox restrictions, menu tracking mode, etc.), this explains exactly what's happening.

### How It Fits ColorWizard
Reference only. Use the library, not the raw Carbon API.

---

## Part 3: `tweakpane/brutalist-theme.css`

**Source:** [cocopon/tweakpane](https://github.com/cocopon/tweakpane) — core theme system
**License:** MIT

### What It Is
A complete industrial/brutalist CSS design system extracted from tweakpane's SCSS source. Includes:
- Full CSS custom property system (50+ variables with `--tp-*` namespace)
- Ready-to-use component classes: `.tp-btn`, `.tp-input`, `.tp-slider`, `.tp-folder`, `.tp-label`
- 4px grid system with 20px unit size
- Pure-CSS chevron (gradient-based, no icons)
- Folder/accordion with left indent line structural indicator

### Why It Was Chosen
- **Educational Brutalism exemplar:** Monospace fonts, 2px sharp edges, 4px spacing grid, state-based styling with no decoration.
- **Self-contained:** Pure CSS, zero JS dependencies for the visual layer.
- **Themeable:** Override any `--tp-*` variable to customize. The abbreviated internal names (`--tp-btn-bg`) map to readable external names (`--tp-button-background-color`).

### How It Fits Your Projects
- **Magpie (Tauri):** Drop this CSS into your Tauri webview for an instant industrial dashboard look. The variables system maps cleanly to Tailwind or CSS-in-JS.
- **Portfolio:** Use the folder/accordion pattern for project case studies. The label-row layout (key: value) is perfect for technical specs.
- **ColorWizard web companion:** If you build a web-based color tool, this theme gives you the utilitarian control panel aesthetic.

### Key Design Tokens
| Token | Value | Purpose |
|-------|-------|---------|
| `--tp-base-font` | Roboto Mono, Source Code Pro, Menlo | Tech authenticity |
| `--tp-unit-size` | 20px | All control heights |
| `--tp-unit-spacing` | 4px | Grid module |
| `--tp-blade-border-radius` | 2px | Sharp utilitarian edges |
| `--tp-base-border-radius` | 6px | Container softness |
| Font size | 11px | Small, technical, dense |

---

## Part 4: `neo_brutalism/NBBoxModifier.swift`

**Source:** [rational-kunal/NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism)
**License:** MIT

### What It Is
The foundation modifier that defines the neo-brutalist aesthetic in SwiftUI:
- **Hard offset shadow:** `shadow(radius: 0, x: 4, y: 4)` — no blur, pure geometric offset
- **Thick border:** `stroke(lineWidth: 2)` with RoundedRectangle overlay
- **Elevated state:** Toggle shadow on/off (for press states, flat cards, etc.)
- **Full theme system:** `NBTheme` struct with environment injection (`@Environment(\.nbTheme)`)

### Why It Was Chosen
- **One modifier, complete aesthetic:** `.nbBox()` transforms any SwiftUI view into neo-brutalist.
- **Environment-based theming:** Swap colors/spacing for your entire view tree with `.nbTheme()`.
- **Dark mode support:** All theme colors have light/dark variants.
- **Zero dependencies:** Pure SwiftUI.

### How It Fits ColorWizard
Apply `.nbBox()` to your color swatch cards, tool buttons, and settings panels. Define a custom `NBTheme` that uses your ColorWizard palette:

```swift
let colorWizardTheme = NBTheme.default.updateBy(
    main: .yourAccentColor,
    borderWidth: 3,       // Heavier for emphasis
    boxShadowX: 6,
    boxShadowY: 6
)
```

### The Signature Recipe
```
Any View + padding + background color + .nbBox()
= Neo-Brutalist element
```

---

## Part 5: `neo_brutalism/NBComponents.swift`

**Source:** rational-kunal/NeoBrutalism — Components/
**License:** MIT

### What It Is
Complete component kit built on `NBBoxModifier`:
- **NBButtonStyle:** Shadow lifts on press (`.interactiveSpring()`), three variants (default/noShadow/reverse)
- **NBCard:** Header/main/footer layout with `.nbBox()` border+shadow
- **NBInputStyle:** TextFieldStyle with flat border, no shadow
- **NBBadge:** Small label with border treatment
- **NBSlider:** Custom drag-based slider with filled progress bar + circle thumb
- **NBProgressViewStyle:** Filled rectangle with divider at progress point

### Why It Was Chosen
- **SwiftUI-native protocols:** Uses `ButtonStyle`, `TextFieldStyle`, `ProgressViewStyle` — drops into standard SwiftUI APIs.
- **Consistent aesthetic:** Every component inherits from the same `NBTheme` environment.
- **Spring animations:** `.interactiveSpring()` on all interactive elements gives tactile feedback.

### How It Fits ColorWizard
| Component | ColorWizard Use |
|-----------|-----------------|
| NBButtonStyle | Tool buttons (eyedropper, palette, export) |
| NBCard | Color swatch display cards |
| NBInputStyle | Hex/RGB value inputs |
| NBSlider | Hue/saturation/brightness controls |
| NBProgressViewStyle | Export progress indicator |
| NBBadge | Color format labels (HEX, RGB, HSL) |

---

## Part 6: `fabric/patterns/extract_wisdom.md`

**Source:** [danielmiessler/fabric](https://github.com/danielmiessler/fabric) — patterns/extract_wisdom/
**License:** MIT

### What It Is
Fabric's most sophisticated prompt template. It extracts structured knowledge from any text into 9 sections: SUMMARY, IDEAS, INSIGHTS, QUOTES, HABITS, FACTS, REFERENCES, ONE-SENTENCE TAKEAWAY, RECOMMENDATIONS.

### Why It Was Chosen
- **Masterclass in prompt engineering:** Hierarchical extraction (raw ideas → refined insights → actionable recommendations), exact word-count constraints (16 words per bullet), anti-repetition rules.
- **Self-contained:** No API calls, no tools — pure system prompt.
- **The "fabric pattern" architecture:** IDENTITY + STEPS + OUTPUT INSTRUCTIONS + INPUT. This 4-section structure is reusable for any prompt template.

### How It Fits Your Agentic Trees
Use this as a template for building your own pattern library. The structure is:
1. **IDENTITY:** Who the AI is
2. **STEPS:** What to do (ordered extraction pipeline)
3. **OUTPUT INSTRUCTIONS:** Formatting constraints
4. **INPUT:** Where user content goes

---

## Part 7: `fabric/patterns/explain_code.md`

**Source:** danielmiessler/fabric — patterns/explain_code/
**License:** MIT

### What It Is
Content-aware code analysis prompt. Automatically detects whether input is source code, security output, or configuration, and adapts its explanation format accordingly.

### Why It Was Chosen
- **Adaptive output:** Single prompt handles 4 input types with different section headings.
- **Minimal:** Just 24 lines — shows that effective prompts don't need to be long.

### How It Fits Your Projects
Template for building an in-app code explainer for ColorWizard's shader/color-math logic, or a documentation generator for Magpie.

---

## Part 8: `fabric/orchestration/agentic_pipeline.py`

**Source:** danielmiessler/fabric — internal/core/chatter.go + template/template.go
**License:** MIT (Python translation)

### What It Is
A Python translation of Fabric's Go orchestration engine. Implements:
- **Pattern Registry:** File-system-based prompt templates with `{{variable}}` substitution
- **Strategy Layer:** Meta-prompts that shape how patterns execute (prepended to system message)
- **Session Management:** Conversation state with JSON persistence
- **Template Engine:** Variable substitution + plugin system
- **Pipeline:** The full `Context + Pattern + Strategy + Language → LLM → Post-process → Save` flow

### Why It Was Chosen
- **The architecture, not the implementation:** Fabric's Go code isn't useful for your Python projects, but its orchestration pattern is.
- **Composable:** Each layer (context, pattern, strategy) is independent. You can use patterns without strategies, or sessions without patterns.
- **Self-contained:** ~200 lines, no external dependencies beyond your LLM client.

### How It Fits Your Agentic Trees
This is the **trunk** of your agent tree. Each "branch" is a Pattern. Each "strategy" is a meta-instruction that shapes execution style. Sessions are the "memory" between interactions.

```
Strategy ("be concise")
    └── Context ("user's project docs")
        └── Pattern ("extract_wisdom")
            └── User Input → LLM → Structured Output
```

Wire it to your Anthropic Python SDK client and you have a composable prompt pipeline.

---

## Cross-Project Synergy Map

```
                    ColorWizard (Swift/macOS)
                   /           |             \
    GlobalHotkey.swift    NBBoxModifier    NBComponents
    (Cmd+Shift+C to       (Border+       (Buttons, Cards,
     toggle picker)        Shadow)        Inputs, Sliders)

                     Magpie (Rust/Tauri)
                    /                    \
        brutalist-theme.css          agentic_pipeline.py
        (Industrial CSS for          (Pattern engine for
         Tauri webview)               AI features)

                    Portfolio (Web)
                   /        |        \
    brutalist-theme.css   Folder    extract_wisdom.md
    (Case study panels)   Accordion  (Content analysis
                         (Projects)   for blog posts)
```

---

## Evaluation Summary

| Part | Self-Contained | Aesthetic Match | Technical Synergy | Verdict |
|------|:-:|:-:|:-:|---------|
| GlobalHotkey.swift | Yes (SPM only) | N/A (logic) | ColorWizard | SHIP IT |
| CarbonHotkeyCore.swift | Reference | N/A | Understanding | KEEP |
| brutalist-theme.css | Yes (pure CSS) | Industrial | Magpie + Portfolio | SHIP IT |
| NBBoxModifier.swift | Yes (SwiftUI) | Neo-Brutalist | ColorWizard | SHIP IT |
| NBComponents.swift | Yes (SwiftUI) | Neo-Brutalist | ColorWizard | SHIP IT |
| extract_wisdom.md | Yes (prompt) | N/A | Agentic Trees | STUDY |
| explain_code.md | Yes (prompt) | N/A | Agentic Trees | STUDY |
| agentic_pipeline.py | Yes (Python) | N/A | Agentic Trees | SHIP IT |
