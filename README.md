# Workshop

This is a workspace for building offline-first creative desktop tools.

## What belongs here

Projects that meet all of these criteria:

- Run fully offline
- Require no accounts or subscriptions
- Store all data locally in user-readable formats
- Are intentionally scoped and finite
- Prioritize stability over novelty
- Respect creative focus and physical craft

This workshop produces finished tools, not platforms or services.

## What does not belong here

- Cloud-dependent software
- Subscription models
- Account systems
- Analytics or telemetry
- Frameworks chosen for novelty rather than stability
- Features added speculatively
- Projects without clear v1 boundaries

## Current projects

- **ColorWizard Desktop** — Painting and color literacy tool
- **Magpie** — Embroidery and pattern translation tool

Each project maintains its own documentation inside `PROJECTS/`.

## Structure

- `PROJECTS/ACTIVE/` — Current work (one canonical folder per project)
- `PROJECTS/ARCHIVE/` — Retired, superseded, or duplicate project folders
- `ASSETS/` — Reusable visuals, logos, references
- `MEDIA/` — Raw/heavy audio-video working files
- `INBOX/` — Required first stop for all new files/folders
- `DECISIONS/` — Documentation of significant choices
- `EXPERIMENTS/` — Short-lived explorations (archived after completion)
- `PHILOSOPHY.md` — Core principles (permanent)

## Intake Rule (non-negotiable)

1. New files do **not** land directly in active folders.
2. Everything new enters through `INBOX/` first.
3. During triage, each item gets exactly one destination:
   - project work → `PROJECTS/ACTIVE/<project>`
   - reusable asset → `ASSETS/<category>`
   - raw media → `MEDIA/<project-or-date>`
   - finished/legacy/reference → `PROJECTS/ARCHIVE/<reason-or-date>`
4. If uncertain, prefix and hold in `INBOX/`:
   - `TODO_` = needs decision
   - `HOLD_` = waiting on dependency
5. Keep `INBOX/` near-empty with a daily sweep.
6. No active duplicates. One source of truth per project.

## 30-second daily triage

- Open `INBOX/`
- Decide: Project / Asset / Media / Archive
- Move each item once (no copy-sprawl)
- Rename unclear items now, not later
- End with `INBOX/` empty or only intentional `TODO_`/`HOLD_` items

## General ethos

- Build from one calm, reliable hub.
- Prefer clarity over clever folder schemes.
- Keep active work lean; archive aggressively.
- Protect momentum with low-friction defaults.
- Optimize for future-you finding things instantly.

This workshop is not a startup. It is a place to build tools that will still work in ten years.
