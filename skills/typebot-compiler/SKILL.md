---
name: typebot-compiler
description: Master orchestrator and stages planner for generating or modifying schema-compliant Typebot JSON workflows.
---

# Typebot Master Compiler Skill & Orchestration Manual

Use this skill as the master guide to coordinate and execute the compilation or modification of Typebot JSON workflow configurations.

---

## 1. Modular Expert Skills Architecture
Instead of relying on a single monolithic file, our Typebot AI features are split into specialized expert instructions. You must refer to them when executing each aspect of workflow compilation:

* 🔐 **Variables & Expressions:** [typebot-variables-expressions](file:///D:/typeBot/.agents/skills/typebot-variables-expressions/SKILL.md) - Handling variable lists, pre-defined variables, and evaluations.
* 📦 **Block Catalog & Node Configuration:** [typebot-block-configuration](file:///D:/typeBot/.agents/skills/typebot-block-configuration/SKILL.md) - Exact formats and keys for all bubble types, inputs, logic, built-in, and custom Forge blocks.
* 🔗 **Routing, Spacing & Edges:** [typebot-routing-edges](file:///D:/typeBot/.agents/skills/typebot-routing-edges/SKILL.md) - visual coordination math, connection mappings, group spacing.
* 🛠️ **Custom JS Code blocks:** [typebot-scripting-code](file:///D:/typeBot/.agents/skills/typebot-scripting-code/SKILL.md) - JavaScript sandbox API and variable updates.
* ✅ **Watcher Sync & Schema Compliance:** [typebot-schema-sync](file:///D:/typeBot/.agents/skills/typebot-schema-sync/SKILL.md) - Zod constraints, root property check, and troubleshooting.

---

## 2. Dynamic Source of Truth
Do not assume static values. Use the templates and schemas inside `reference/` (`typebot-complete-schemas.md` and templates) as your live database reference. If the Typebot codebase is open, examine actual blocks under `packages/blocks/` and custom forge blocks under `packages/forge/blocks/` for direct definitions.

---

## 3. Staged Compilation Workflow
You must construct or edit workflows using this sequential, three-stage approach:

### 🔐 Stage 0: Credential Initialization
If the workflow requires integrations (e.g. OpenAI, Google Sheets, Make, Cal.com):
1. Place completely empty, unconfigured placeholders for these blocks onto the canvas first.
2. Instruct the user to click these blocks, link their accounts, and generate credentials.
3. Pause and wait for the user to confirm they have set up their credentials and provided the generated `credentialsId`.

### 🚀 Stage 1: Groups, Coordinates & Nodes
Once credentials are set up:
1. Define all group containers on a visual coordinate grid (spacing horizontal by `x: +400`, vertical by `y: +300` to avoid overlaps).
2. Declare variables in the root `"variables"` array.
3. Build the individual blocks inside the groups' `"blocks"` arrays using details from the **Block Catalog** sub-skill.

### 🔗 Stage 2: Connections & Edges
Once groups and blocks are generated:
1. Build the edge connections in the root `"edges"` array (using `eventId`, `blockId`, or `itemId` as sources, pointing to a target `groupId`).
2. Add corresponding `outgoingEdgeId` properties to the connected blocks/items. Do not use `null` for disconnected paths; omit the key instead.

---

## 4. Pre-Save Verification Checklist
Before saving any JSON configuration file:
* Run the validation checklist from the **Schema & Sync** sub-skill.
* Ensure no overlaps occur on coordinates.
* Double-check that all block type strings are correctly cased.
