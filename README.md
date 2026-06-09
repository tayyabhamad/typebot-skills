# Typebot Skills for AI Agents 🤖

A collection of 6 highly detailed, domain-specific expert skills designed to enhance AI coding assistants (like Claude, Gemini, ChatGPT, etc.) for compiling, building, and validating production-ready, schema-compliant Typebot JSON workflows.

These skills ensure that your AI agent constructs workflow JSON structures that exactly match Typebot's native database models, visual coordinate layout grids, variable interpolation conventions, and sandboxed scripting environments without errors.

---

## 🚀 The 6 Expert Skills

### 1. ⚙️ [typebot-compiler](./skills/typebot-compiler/SKILL.md)
* **Purpose:** The master orchestration flow.
* **Details:** Defines the 3-stage compilation protocol (Stage 0: Credentials, Stage 1: Groups/Nodes, Stage 2: Connections/Edges) to build workflows step-by-step.

### 2. 📦 [typebot-block-configuration](./skills/typebot-block-configuration/SKILL.md)
* **Purpose:** Block catalog and JSON option schemas.
* **Details:** Detailed templates and properties for all standard Bubble nodes (Text, Embed, Audio, etc.), User Input nodes (Picture Choice, Multi-choice, etc.), Logic blocks (Condition, Jump, Return, AB test, etc.), and integrations (built-in integrations + Forge blocks like Cal.com, Zendesk, Groq, Perplexity, Anthropic, ElevenLabs).

### 3. 🔐 [typebot-variables-expressions](./skills/typebot-variables-expressions/SKILL.md)
* **Purpose:** Variables declaration and interpolation syntax.
* **Details:** Standard conventions for variable declaration models, session properties, pre-defined variables, and parsing values dynamically.

### 4. 🔗 [typebot-routing-edges](./skills/typebot-routing-edges/SKILL.md)
* **Purpose:** Canvas routing, coordinates, and edges.
* **Details:** Math guidelines for group coordinates (horizontal spacing `+400`, vertical `+300`) to avoid visual overlaps, and routing configurations for linear paths, item-level branching, and default catch-alls.

### 5. ✅ [typebot-schema-sync](./skills/typebot-schema-sync/SKILL.md)
* **Purpose:** Database constraints and key completeness.
* **Details:** Complete requirements check for all 23 root-level keys of `typebotSchema` and strict union rules to pass engine validators.

### 6. 🛠️ [typebot-scripting-code](./skills/typebot-scripting-code/SKILL.md)
* **Purpose:** Custom JavaScript execution in Code blocks.
* **Details:** Variable mapping, changing execution values via `setVariable()`, and fetch API responses inside the isolated VM sandbox.

---

## 🛠️ Installation & Usage

### 1. Claude Code
If you are using Claude Code, install these plugins/skills directly via:
```bash
/plugin install https://github.com/tayyabhamad/typebot-skills.git
```

### 2. Copy-Paste Prompting
Simply copy the markdown contents of any specific skill (like the block catalog) and paste it into your prompt to instruct the AI with correct schemas:
* [typebot-block-configuration](./skills/typebot-block-configuration/SKILL.md)
* [typebot-scripting-code](./skills/typebot-scripting-code/SKILL.md)

### 3. Manual Project Import
Download/clone this repository and add it to your custom AI project templates or folder contexts as background training files.
