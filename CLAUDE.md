# Typebot Skills Development Guide (CLAUDE.md)

This manual provides local development commands and guidelines for editing and building these Typebot AI expert skills.

## 🛠️ Build Commands
* **Build/Bundle Skills:** `./build.sh` (executes the bundler script to verify markdown formats)

## 📌 Development Guidelines
1. **Adding Blocks:** When adding new block configurations, verify the type string against the actual source file under `packages/blocks/` (or `packages/forge/blocks/` for custom integrations) inside the Typebot codebase.
2. **Schema Validity:** Ensure Zod-like constraints in [typebot-schema-sync](./skills/typebot-schema-sync/SKILL.md) are strictly updated if root keys change in standard Typebot imports.
3. **No Null References:** In edge connection examples, always omit disconnected `outgoingEdgeId` properties rather than specifying `null` or empty strings.
