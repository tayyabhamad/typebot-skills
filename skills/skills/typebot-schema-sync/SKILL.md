---
name: typebot-schema-sync
description: Validates Typebot V6 JSON configurations against database schema constraints.
---

# Typebot Schema & Validation Manual

Use this skill to verify that a generated or modified Typebot JSON file complies with standard Typebot database schemas.

---

## 1. Zod Validation & Schema Completeness

Typebot parses the JSON against a Zod schema matching database models. Any missing required keys or incorrect types will cause the parsing to fail with **"input validation failed"**.

> [!IMPORTANT]
> **Import vs Export distinction:** When IMPORTING a workflow JSON, the server STRIPS and REGENERATES these fields (they are in `omittedProps` in `handleImportTypebot.ts`): `id`, `workspaceId`, `publicId`, `createdAt`, `updatedAt`, `customDomain`, `riskLevel`, `isClosed`, `isArchived`, `whatsAppCredentialsId`, `spaceId`, `resultsTablePreferences`, `selectedThemeTemplateId`.
> You may include them for completeness, but they are ignored — they will NOT cause validation failures if wrong, and NOT cause failures if missing.

### Minimum Required Root-Level Keys for Import
These keys are what the Zod schema actually validates during import:

1. `"version"` (string): Always `"6.1"`
2. `"name"` (string): Name of the typebot
3. `"groups"` (array): Array of Group objects containing blocks — **groups must not be empty arrays (`[]`)**
4. `"events"` (array): Array containing the start event object
5. `"edges"` (array): Array of edge connections
6. `"variables"` (array): Array of variable definitions (can be `[]`)
7. `"theme"` (object): Can be a minimal `{}` or a partial object — fully optional sub-keys
8. `"settings"` (object): Can be a minimal `{}` or partial — fully optional sub-keys

### Recommended Additional Root-Level Keys (include for completeness)
- `"id"` (string): Any string — ignored on import, regenerated
- `"workspaceId"` (string): Any string — ignored on import
- `"folderId"` (null): `null`
- `"publicId"` (null): `null`
- `"icon"` (string|null): Emoji icon or `null`
- `"createdAt"` (string): ISO timestamp
- `"updatedAt"` (string): ISO timestamp

---

## 2. Verified Sub-Schema Details

### A. Theme Configuration (`"theme"`)
Must conform to `themeSchema`:
```json
"theme": {
  "general": {
    "font": {
      "type": "Google", // or "Custom"
      "family": "Inter"
    },
    "background": {
      "type": "Color", // "Color", "Image", "None"
      "content": "#ffffff"
    },
    "progressBar": {
      "isEnabled": false,
      "color": "#0042da",
      "backgroundColor": "#f7f8fa",
      "placement": "top",
      "thickness": 4,
      "position": "fixed"
    }
  },
  "chat": {
    "container": {
      "backgroundColor": "#ffffff",
      "color": "#333333",
      "maxWidth": "600px"
    },
    "hostBubbles": {
      "backgroundColor": "#f7f8fa",
      "color": "#333333"
    },
    "guestBubbles": {
      "backgroundColor": "#0042da",
      "color": "#ffffff"
    },
    "buttons": {
      "backgroundColor": "#0042da",
      "color": "#ffffff"
    },
    "inputs": {
      "backgroundColor": "#ffffff",
      "color": "#333333",
      "placeholderColor": "#999999"
    }
  },
  "customCss": ""
}
```

### B. Settings Configuration (`"settings"`)
Must conform to `settingsSchema`:
```json
"settings": {
  "general": {
    "isBrandingEnabled": false,
    "isTypingEmulationEnabled": true,
    "isInputPrefillEnabled": true,
    "isHideQueryParamsEnabled": false,
    "isNewResultOnRefreshEnabled": false
  },
  "typingEmulation": {
    "enabled": true,
    "speed": 30,
    "maxDelay": 2,
    "delayBetweenBubbles": 0.5,
    "isDisabledOnFirstMessage": false
  },
  "metadata": {
    "title": "My Custom Chatbot",
    "description": "Custom customer support bot",
    "allowIndexing": false
  }
}
```

---

## 3. Strict Schema Rules

### A. No Null outgoingEdgeIds
If a block, item, or event is not connected to any destination:
* **Rule:** Omit the `outgoingEdgeId` property completely from the object.
* **Incorrect:** `"outgoingEdgeId": null` or `"outgoingEdgeId": ""`
* **Reason:** The Zod validator expects `outgoingEdgeId` to be either a valid string referencing an edge ID or undefined/omitted.

### B. Discriminated Union Type Casing
Block types are validated via Zod discriminated unions. Casing must be exact:
* **Bubbles:** `"text"`, `"image"`, `"video"`, `"audio"`, `"embed"`
* **Inputs:** `"text input"`, `"number input"`, `"email input"`, `"url input"`, `"date input"`, `"time input"`, `"phone number input"`, `"choice input"`, `"rating input"`, `"file input"`, `"picture choice input"`, `"payment input"`, `"cards"`
* **Logic:** `"Set variable"`, `"Condition"`, `"Redirect"`, `"Code"`, `"Wait"`, `"Jump"`, `"Typebot link"`, `"AB test"`, `"Return"`, `"webhook"`
* **Integrations:** `"OpenAI"`, `"Webhook"` (casing differences: `"Webhook"` with capital W for integrations, lowercase `"webhook"` for logic webhooks), `"Email"`, `"Google Sheets"`, `"Google Analytics"`, `"Chatwoot"`, `"Pixel"`.
* **Forge Blocks:** Lowercase matching the forge block id. Complete list from source: `"openai"`, `"anthropic"`, `"groq"`, `"mistral"`, `"deepseek"`, `"perplexity"`, `"together-ai"`, `"open-router"`, `"dify-ai"`, `"cal-com"`, `"elevenlabs"`, `"zendesk"`, `"nocodb"`, `"gmail"`, `"qr-code"`, `"posthog"`, `"segment"`, `"blink"`, `"chat-node"`.
  > **⚠️ OpenAI Casing Trap:** The legacy built-in block is `"OpenAI"` (uppercase). The Forge block is `"openai"` (lowercase). They are different blocks with different options schemas.

### C. Escaping Nested JSON Payloads
When writing bodies in HTTP requests or Code scripts inside the JSON container:
* Escape internal double quotes with `\"`.
* Escape control characters like newlines with `\n`.
* **Example:**
  ```json
  "body": "{\n  \"message\": \"Hello {{userName}}\"\n}"
  ```
