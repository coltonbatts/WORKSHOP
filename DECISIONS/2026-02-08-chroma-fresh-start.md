# Chroma: Fresh Start for ColorWizard Desktop

**Date:** February 8, 2026
**Decision:** Start Chroma as a clean rebuild, abandon ColorWizard folder

The existing ColorWizard folder accumulated too much cruft from 18+ iterations. Rather than continuing to untangle the mess, we're starting fresh with a new project name.

## Why a new name

- **"ColorWizard" was overloaded** — referred to the web app, the desktop pivot, various experiments
- **Confusion** — multiple folders with similar names made it unclear which was canonical
- **Fresh start energy** — "Chroma" is simple, unused, and purpose-built for this version

## What Chroma is

- Offline-first color tool for artists
- Swiss army knife for color work
- Spiritual successor to ColorWizard Desktop vision
- Tauri + React + TypeScript (matching Magpie's stack)

## What we keep from ColorWizard

- `spectral.js` integration for spectral color analysis
- `culori` for color manipulation and conversion
- DMC floss database and matching logic
- Palette generation algorithms
- Color theory utilities

## What we drop

- Firebase / cloud sync
- Stripe / payments
- Authentication
- Web app remnants
- Feature creep from 18 iterations

## Structure

```
Chroma/
├── src/           # React frontend
├── src-tauri/     # Rust backend
└── README.md      # Single source of truth
```

## Business model

One-time purchase. No subscriptions. No accounts.

## Scope for v1

Core features only:
- Color mixing and palette building
- Spectral analysis
- Paint matching (DMC, potentially others)
- Export to common formats

No:
- Cloud sync
- Social features
- Subscription tiers
- Web version

Ship v1. Done.
