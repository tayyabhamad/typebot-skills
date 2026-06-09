---
name: typebot-schema-sync
description: Validates Typebot V6 JSON configurations against database schema constraints.
---

# Typebot Schema & Validation Manual

Use this skill to verify that a generated or modified Typebot JSON file complies with standard Typebot database schemas.

---

## 1. Zod Validation & Schema Completeness
Typebot parses the JSON against a Zod schema matching database models. Any missing required keys or incorrect types will cause the parsing to fail.

### All 23 Required Root-Level Keys
Every Typebot JSON configuration MUST include these exact root keys. Do not omit them; use default values or `null` as specified:

1. `"version"` (string): Always `"6.1"`
2. `"id"` (string): A unique `cuid` (e.g. `"clvqu4l5j00015bxibaf44slo"`)
3. `"name"` (string): Name of the typebot
4. `"workspaceId"` (string): The workspace ID (e.g. `"proWorkspace"`)
5. `"groups"` (array): Array of Group objects containing blocks
6. `"events"` (array): Array containing the start event object
7. `"edges"` (array): Array containing connections between nodes
8. `"variables"` (array): Array containing variable definitions
9. `"theme"` (object): Style rules (`general`, `chat`, etc.)
10. `"settings"` (object): Typing options, metadata, and branding config
11. `"createdAt"` (string): ISO timestamp (e.g. `"2024-05-03T15:33:41.527Z"`)
12. `"updatedAt"` (string): ISO timestamp
13. `"selectedThemeTemplateId"` (null/string): Typically `null`
14. `"icon"` (null/string): Emoji or URL representing the bot icon, or `null`
15. `"folderId"` (null/string): Folder containing the bot, or `null`
16. `"publicId"` (null/string): Public URL slug, or `null`
17. `"customDomain"` (null/string): Custom web domain, or `null`
18. `"resultsTablePreferences"` (null/object): Table layout settings, or `null`
19. `"isArchived"` (boolean): Typically `false`
20. `"isClosed"` (boolean): Typically `false`
21. `"whatsAppCredentialsId"` (null/string): WhatsApp API credentials ID, or `null`
22. `"riskLevel"` (null/number): System security risk status, or `null`
23. `"spaceId"` (null/string): Spaces organization ID, or `null`

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
