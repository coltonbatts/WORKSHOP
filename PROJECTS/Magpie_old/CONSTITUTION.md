# Magpie Constitution

This document defines the non-negotiable constraints for Magpie.

These rules are permanent and cannot be changed without abandoning the project.

## Must

- Function fully offline
- Store all patterns and data locally in user-readable formats
- Launch and operate without internet access
- Use stable, proven libraries
- Export patterns in open formats (JSON, plain text, SVG)
- Respect system privacy settings
- Work without user accounts
- Provide clear documentation for all file formats

## Must not

- Require internet access for any core feature
- Phone home or transmit analytics
- Require user accounts or authentication
- Store data in proprietary or binary-only formats
- Include automatic update mechanisms that cannot be disabled
- Depend on external services or APIs
- Include advertising or promotional content
- Track user behavior

## Data ownership

All patterns and data created in Magpie belong to the user. Data must be:

- Stored in plain, documented formats
- Exportable at any time
- Portable to other tools or physical use
- Readable without Magpie installed

## Updates

Updates must:

- Be optional
- Never break existing pattern files or workflows
- Include full release notes
- Be manually installed by the user

## Breaking changes

Breaking changes to file formats or core behavior are prohibited. If a change would break existing patterns, it does not happen.

## Scope

Magpie is a tool for embroidery pattern preparation and thread management. Features outside this scope are excluded, regardless of demand or ease of implementation.

Feature requests that violate these constraints are declined.
