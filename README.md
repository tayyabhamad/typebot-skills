# Typebot Skills for AI Agents 🤖

A collection of 6 highly detailed, domain-specific expert skills designed to enhance AI coding assistants (Claude Code, Gemini, ChatGPT, etc.) for compiling, building, and validating production-ready, schema-compliant **Typebot V6** JSON workflows.

These skills ensure your AI agent constructs workflow JSON structures that exactly match Typebot's native database models, visual coordinate layout grids, variable interpolation conventions, and sandboxed scripting environments — without errors.

---

## 🚀 The 6 Expert Skills

### 1. ⚙️ [typebot-compiler](./typebot-compiler/SKILL.md)
* **Purpose:** Master orchestration flow — the entry point.
* **Details:** Defines the 3-stage compilation protocol (Stage 0: Credentials, Stage 1: Groups/Nodes, Stage 2: Connections/Edges) and links to all sub-skills.

### 2. 📦 [typebot-block-configuration](./typebot-block-configuration/SKILL.md)
* **Purpose:** Complete block catalog with JSON schemas.
* **Details:** Schemas for all Bubble nodes (Text, Embed, Audio, Video, Image), User Input nodes (Choice, Cards, Picture Choice, Rating, File, Payment, Date, Phone), Logic blocks (Condition, Jump, Return, AB test, Set Variable, Code, Webhook), built-in integrations, and all **19 Forge blocks** (OpenAI, Anthropic, Groq, Mistral, Deepseek, Perplexity, ElevenLabs, Cal.com, NocoDB, Gmail, QR Code, OpenRouter, Together AI, Dify.AI, and more).

### 3. 🔐 [typebot-variables-expressions](./typebot-variables-expressions/SKILL.md)
* **Purpose:** Variable declaration and `{{interpolation}}` syntax.
* **Details:** Variable declaration schema, session properties, system variables, and correct `{{Variable Name}}` usage in blocks and API payloads.

### 4. 🔗 [typebot-routing-edges](./typebot-routing-edges/SKILL.md)
* **Purpose:** Canvas coordinates, edges, and routing connections.
* **Details:** Grid spacing rules (horizontal `+350–450`, vertical `+250–350`), edge schema, block-to-group vs item-to-group branching, and fallback catch-all patterns.

### 5. ✅ [typebot-schema-sync](./typebot-schema-sync/SKILL.md)
* **Purpose:** Zod schema validation and required root keys.
* **Details:** All 23 required root-level keys, strict discriminated union type casings, OpenAI casing trap warning, null-safety rules, and escaped JSON payload patterns.

### 6. 🛠️ [typebot-scripting-code](./typebot-scripting-code/SKILL.md)
* **Purpose:** JavaScript execution in `Code` blocks.
* **Details:** Variable reading patterns, `setVariable()` API, sandboxed `fetch` API usage, and common scripting pitfalls.

---

## 🛠️ Installation & Usage

### Method 1 — Claude Code (Recommended)
Install directly as a Claude Code plugin:
```bash
/plugin install tayyabhamad/typebot-skills
```

Or via marketplace:
```bash
/plugin marketplace add tayyabhamad/typebot-skills
# Then install:
/plugin install typebot-skills
```

### Method 2 — Manual Clone
```bash
git clone https://github.com/tayyabhamad/typebot-skills.git
```
Copy the skill files into your Claude Code skills directory or paste them into your AI project context.

### Method 3 — Copy-Paste Prompting
Copy the markdown of any specific skill and paste it directly into your prompt to give the AI the correct schemas:
- [typebot-block-configuration](./typebot-block-configuration/SKILL.md) — block schemas catalog
- [typebot-schema-sync](./typebot-schema-sync/SKILL.md) — validation rules

---

## 🤝 Contributing & Feedback

Since Typebot.io evolves frequently, contributions are welcome!

* **Report Schema Errors:** If you find incorrect block schemas, missing fields, or wrong type casings, open an issue in the [GitHub Issue Tracker](https://github.com/tayyabhamad/typebot-skills/issues).
* **Contribute New Blocks:** Submit a Pull Request to add new Forge block definitions, update existing schemas, or improve routing rules.
* **Test with a Real Workflow:** Try building a Typebot JSON with these skills and report any validation failures from the local watcher.
