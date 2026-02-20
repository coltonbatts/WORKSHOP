# ColorWizard Desktop Pivot

**Date:** February 2026
**Decision:** Discontinue web ColorWizard, build ColorWizard Desktop as a workshop tool

We are discontinuing ColorWizard as a web-first, account-based product. Firebase, Stripe, and all associated infrastructure are intentionally abandoned. ColorWizard Desktop is a new product with a different philosophy: ownership over access.

This prevents future-you from reopening the wound.

## What we're leaving behind

The web version of ColorWizard (colorwizard.app) had:
- Firebase authentication and database
- Stripe payment integration
- $1 Pro tier subscription model
- Cloud palette sync (planned)
- Web hosting and deployment infrastructure
- SaaS business model assumptions

All of this is abandoned. Not paused. Not "maybe later." Abandoned.

## Why

The web version contradicted the workshop philosophy in fundamental ways:

**Cloud dependency**: Firebase means user data lives on Google's servers. Users don't own their palettes.

**Subscription thinking**: Even at $1, a subscription is recurring access, not ownership. It's the wrong model.

**Feature fragmentation**: "Pro tier" means core features get paywalled. The tool becomes a service.

**Technical complexity**: Authentication, database rules, payment processing, and hosting create maintenance burden and ongoing costs.

These aren't implementation details. They're philosophical conflicts.

The web version can exist as its own thing with its own business model. But it doesn't belong in this workshop.

## What ColorWizard Desktop is

ColorWizard Desktop is a new tool built from scratch for the workshop:

- Tauri desktop application
- Runs fully offline
- All data stored locally in user-readable formats
- One-time purchase (no subscriptions)
- No accounts, no authentication, no cloud
- Core features never paywalled

The color engine logic (Spectral.js, mixing algorithms, DMC matching) can be borrowed from the web version. Everything else is rebuilt for desktop.

## Technical approach

- **Framework:** Tauri + React + TypeScript (matches Magpie)
- **Storage:** Local filesystem using Tauri APIs
- **Data format:** JSON for palettes and preferences
- **Distribution:** Downloadable app, sold once
- **Updates:** Manual, optional, never breaking

## Business model

Sell the app once. $20-40 range. User owns it. Done.

No recurring revenue. No growth metrics. No user retention optimization.

If the tool is good, people buy it. If it's not, they don't.

## What stays the same

The core problem ColorWizard solves:
- Help painters understand color
- Translate digital colors to physical paint
- Build usable palettes for real work

The purpose doesn't change. The delivery model does.

## What this means for the web version

The web ColorWizard can continue existing as a separate product with a separate codebase. Different repo, different philosophy, different business model.

But it has no influence on the workshop. Its decisions (cloud sync, Pro tier, Firebase) don't leak into ColorWizard Desktop.

Clean separation.

## Why this decision is permanent

This isn't a "pivot" in the startup sense. It's a boundary.

The workshop builds offline-first, owned tools. If ColorWizard doesn't fit that model, it doesn't belong here.

This decision document exists so future-you doesn't forget why:
- No Firebase "just for user sync"
- No Stripe "just for one-time payments"
- No Pro tier "just for advanced features"
- No cloud anything "just for convenience"

Every compromise starts with "just for."

This is the line.

## Next steps

1. Build ColorWizard Desktop in `PROJECTS/ColorWizard/app`
2. Port color engine logic (Spectral.js, algorithms)
3. Design for local-first from day one
4. Ship when v1 scope is complete

No roadmap beyond v1. No promises of future features. Build the tool, ship it, move on.
