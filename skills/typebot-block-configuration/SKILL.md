---
name: typebot-block-configuration
description: Detailed reference catalog containing schemas, options, and JSON examples for all Typebot bubbles, inputs, logic, and integrations.
---

# Typebot Block Configuration & Catalog Manual

Use this skill to determine the exact properties, structure, and options for any block type in a Typebot V6 workflow.

---

## 1. Bubbles (Output Blocks)

Bubbles display content to the user without expecting input.

### A. Text Bubble (`"type": "text"`)
Renders rich text.
```json
{
  "id": "block-id-cuid",
  "type": "text",
  "content": {
    "richText": [
      {
        "type": "p",
        "children": [{ "text": "Paragraph text. You can use **markdown** or {{variables}}." }]
      }
    ]
  }
}
```

### B. Image Bubble (`"type": "image"`)
Renders an image.
```json
{
  "id": "block-id-cuid",
  "type": "image",
  "content": {
    "url": "https://example.com/image.png",
    "clickLink": {
      "url": "https://example.com/target-redirect",
      "alt": "Alt text description"
    }
  }
}
```

### C. Video Bubble (`"type": "video"`)
Embeds video URLs (YouTube, Vimeo, MP4 direct).
```json
{
  "id": "block-id-cuid",
  "type": "video",
  "content": {
    "url": "https://example.com/video.mp4"
  }
}
```

### D. Audio Bubble (`"type": "audio"`)
Plays an audio track.
```json
{
  "id": "block-id-cuid",
  "type": "audio",
  "content": {
    "url": "https://example.com/audio.mp3",
    "isAutoplayEnabled": true
  }
}
```

### E. Embed Bubble (`"type": "embed"`)
Embeds external iframe or pages.
```json
{
  "id": "block-id-cuid",
  "type": "embed",
  "options": {
    "url": "https://example.com",
    "height": 400,
    "waitForEvent": {
      "isEnabled": true,
      "name": "payment_success",
      "saveDataInVariableId": "var-save-id"
    }
  }
}
```

---

## 2. Inputs (User Interaction Blocks)

Input blocks capture user responses and save them in variables.

### A. Standard Inputs (Text, Number, Email, URL, Phone)
All share a similar structure.
* **Text Input:** `"type": "text input"`
* **Number Input:** `"type": "number input"`
* **Email Input:** `"type": "email input"`
* **URL Input:** `"type": "url input"`
* **Phone Input:** `"type": "phone number input"`

```json
{
  "id": "block-id-cuid",
  "type": "text input",
  "options": {
    "variableId": "var-id-cuid",
    "placeholder": "Enter your answer...",
    "isLong": false // True for text area (text input only)
  }
}
```
*For Number Input:* You can specify `"min": 0, "max": 100` inside `options`.

### B. Date & Time Inputs
* **Date Input:** `"type": "date input"`
```json
{
  "id": "block-id-cuid",
  "type": "date input",
  "options": {
    "variableId": "var-id-cuid",
    "isRange": false,
    "hasTime": false
  }
}
```
* **Time Input:** `"type": "time input"`
```json
{
  "id": "block-id-cuid",
  "type": "time input",
  "options": {
    "variableId": "var-id-cuid"
  }
}
```

### C. Choice Input (Buttons) (`"type": "choice input"`)
Presents selectable buttons.
```json
{
  "id": "block-id-cuid",
  "type": "choice input",
  "items": [
    {
      "id": "choice-item-1",
      "content": "Option A",
      "outgoingEdgeId": "edge-a-id"
    },
    {
      "id": "choice-item-2",
      "content": "Option B",
      "outgoingEdgeId": "edge-b-id"
    }
  ],
  "options": {
    "variableId": "var-selection-id",
    "isMultipleChoice": false,
    "buttonLabel": "Submit"
  }
}
```

### D. Picture Choice (`"type": "picture choice input"`)
Cards with images.
```json
{
  "id": "block-id-cuid",
  "type": "picture choice input",
  "items": [
    {
      "id": "pic-item-1",
      "pictureSrc": "https://example.com/pic.jpg",
      "title": "Choice Title",
      "description": "Choice Description",
      "outgoingEdgeId": "edge-id"
    }
  ],
  "options": {
    "variableId": "var-id-cuid",
    "isMultipleChoice": false
  }
}
```

### E. File Input (`"type": "file input"`)
Allows file uploads.
```json
{
  "id": "block-id-cuid",
  "type": "file input",
  "options": {
    "variableId": "var-files-urls-id",
    "isMultiple": true,
    "maxSize": 10
  }
}
```

### F. Rating (`"type": "rating input"`)
Collects rating score.
```json
{
  "id": "block-id-cuid",
  "type": "rating input",
  "options": {
    "variableId": "var-rating-id",
    "length": 5,
    "buttonType": "Star" // "Star", "Number", "Heart"
  }
}
```

### G. Cards (Carousel Input) (`"type": "cards"`)
Displays a scrollable carousel of image cards. Each card item can have multiple clickable buttons (called `paths`) — each path routes to a different group.

> [!IMPORTANT]
> Cards items do NOT use a top-level `outgoingEdgeId` or `buttonLabel`. Routing is via the nested `paths` array, and field-to-variable mapping is via `saveResponseMapping` in `options`.

```json
{
  "id": "block-id-cuid",
  "type": "cards",
  "items": [
    {
      "id": "card-item-1",
      "imageUrl": "https://example.com/image.jpg",
      "title": "Product A",
      "description": "Short description of the card.",
      "paths": [
        {
          "id": "path-item-1-btn-1",
          "text": "Choose This",
          "outgoingEdgeId": "edge-card-a"
        }
      ]
    }
  ],
  "options": {
    "saveResponseMapping": [
      { "field": "Title", "variableId": "var-selected-title-id" },
      { "field": "Image URL", "variableId": "var-selected-img-id" },
      { "field": "Internal Value", "variableId": "var-internal-val-id" }
    ]
  }
}
```
**`field` values** (from `cardMappableFields`): `"Image URL"`, `"Title"`, `"Description"`, `"Button"`, `"Internal Value"`.

### H. Payment Input (`"type": "payment input"`)
Stripe checkout inside bot.
```json
{
  "id": "block-id-cuid",
  "type": "payment input",
  "options": {
    "provider": "Stripe",
    "credentialsId": "stripe-cred-id",
    "amount": "19.99",
    "currency": "USD"
  }
}
```

---

## 3. Logic Blocks

Logic blocks perform conditional routes, operations, script executions, or changes in variable state.

### A. Set Variable (`"type": "Set variable"`)
Sets variable values.
```json
{
  "id": "block-id-cuid",
  "type": "Set variable",
  "options": {
    "variableId": "var-target-id",
    "type": "value", // "value", "random", "empty"
    "value": "Assign this string or {{anotherVariable}}"
  }
}
```

### B. Condition (`"type": "Condition"`)
Branches based on rules.
```json
{
  "id": "block-id-cuid",
  "type": "Condition",
  "items": [
    {
      "id": "cond-item-1",
      "content": {
        "logicalOperator": "AND",
        "comparisons": [
          {
            "id": "comp-id",
            "variableId": "var-test-id",
            "comparisonOperator": "Equal to",
            "value": "Yes"
          }
        ]
      },
      "outgoingEdgeId": "edge-true"
    }
  ],
  "outgoingEdgeId": "edge-false" // Omitted if no false path
}
```
*Comparison Operators:* "Equal to", "Not equal to", "Contains", "Does not contain", "Greater than", "Less than", "Is set", "Is not set", "Starts with", "Ends with".

### C. Script (Code Block) (`"type": "Code"`)
Executes JS.
```json
{
  "id": "block-id-cuid",
  "type": "Code",
  "options": {
    "content": "console.log('Variables inside JS: {{userName}}');"
  }
}
```

### D. Redirect (`"type": "Redirect"`)
Redirects user to a URL.
```json
{
  "id": "block-id-cuid",
  "type": "Redirect",
  "options": {
    "url": "https://google.com",
    "isNewTab": true
  }
}
```

### E. Jump (`"type": "Jump"`)
Jumps directly to a target group on the canvas.
```json
{
  "id": "block-id-cuid",
  "type": "Jump",
  "options": {
    "groupId": "target-group-id"
  }
}
```

### F. Wait (`"type": "Wait"`)
Pauses execution.
```json
{
  "id": "block-id-cuid",
  "type": "Wait",
  "options": {
    "seconds": 5
  }
}
```

### G. Typebot Link (`"type": "Typebot link"`)
Binds another typebot flow.
```json
{
  "id": "block-id-cuid",
  "type": "Typebot link",
  "options": {
    "typebotId": "target-typebot-id",
    "groupId": "target-start-group-id"
  }
}
```

### H. AB Test (`"type": "AB test"`)
Splits traffic randomly between two paths.

> [!IMPORTANT]
> Path values are **lowercase** string literals `"a"` and `"b"` — Zod validates `z.literal("a")` and `z.literal("b")`. Using uppercase WILL break schema validation.

```json
{
  "id": "block-id-cuid",
  "type": "AB test",
  "items": [
    { "id": "ab-a", "path": "a", "outgoingEdgeId": "edge-a" },
    { "id": "ab-b", "path": "b", "outgoingEdgeId": "edge-b" }
  ],
  "options": {
    "aPercent": 50
  }
}
```
`aPercent` (number, 0–100): Percentage of traffic routed to path `"a"`. Defaults to 50/50 split.

### I. Return (`"type": "Return"`)
Returns to the calling typebot link.
```json
{
  "id": "block-id-cuid",
  "type": "Return"
}
```

### J. Webhook (Logic Webhook) (`"type": "webhook"`)
Triggers workspace webhook configuration.
```json
{
  "id": "block-id-cuid",
  "type": "webhook",
  "options": {
    "responseVariableMapping": [
      {
        "id": "mapping-id",
        "bodyPath": "data.status",
        "variableId": "var-status-id"
      }
    ]
  }
}
```

---

## 4. Built-in Integration Blocks

### A. OpenAI (`"type": "OpenAI"`)
Legacy OpenAI block.
```json
{
  "id": "block-id-cuid",
  "type": "OpenAI",
  "options": {
    "action": "Create chat completion",
    "model": "gpt-4o",
    "messages": [
      { "role": "system", "content": "Assistant prompt" },
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "item": "Message content", "variableId": "var-reply-id" }
    ]
  }
}
```

### B. HTTP Request (Integration Webhook) (`"type": "Webhook"`)
Webhook caller block (Note: casing is uppercase `"Webhook"` for the integration, lowercase `"webhook"` for workspace webhook).
```json
{
  "id": "block-id-cuid",
  "type": "Webhook",
  "options": {
    "webhook": {
      "url": "https://api.example.com/endpoint",
      "method": "POST",
      "headers": [
        { "id": "header-1", "key": "Content-Type", "value": "application/json" }
      ],
      "body": "{\n  \"name\": \"{{userName}}\"\n}"
    },
    "responseVariableMapping": [
      {
        "id": "mapping-1",
        "bodyPath": "data.id",
        "variableId": "var-user-id"
      }
    ]
  }
}
```

### C. Google Sheets (`"type": "Google Sheets"`)
```json
{
  "id": "block-id-cuid",
  "type": "Google Sheets",
  "options": {
    "credentialsId": "sheet-cred-id",
    "action": "Insert row",
    "spreadsheetId": "spread-id",
    "sheetName": "Sheet1",
    "cells": [
      { "id": "cell-1", "column": "Name", "value": "{{userName}}" }
    ]
  }
}
```

### D. Send Email (SMTP) (`"type": "Email"`)
```json
{
  "id": "block-id-cuid",
  "type": "Email",
  "options": {
    "credentialsId": "smtp-cred-id",
    "isCustomBody": true,
    "recipients": ["admin@example.com"],
    "subject": "New lead: {{userName}}",
    "body": "A new lead registered with email: {{email}}"
  }
}
```

### E. Chatwoot (`"type": "Chatwoot"`)
```json
{
  "id": "block-id-cuid",
  "type": "Chatwoot",
  "options": {
    "websiteToken": "token",
    "baseUrl": "https://chatwoot.com"
  }
}
```

### F. Google Analytics (`"type": "Google Analytics"`)
```json
{
  "id": "block-id-cuid",
  "type": "Google Analytics",
  "options": {
    "trackingId": "UA-XXXXX",
    "action": "Send event",
    "category": "Lead",
    "eventAction": "Signup"
  }
}
```

---

## 5. Forge Blocks (New Custom Integrations)

Forge blocks are modular integrations. Their `"type"` matches their integration `id` from the source code. They require `credentialsId` in `options` when authentication is needed.

> [!IMPORTANT]
> All 19 Forge block IDs are:
> `"openai"`, `"anthropic"`, `"groq"`, `"mistral"`, `"deepseek"`, `"perplexity"`, `"together-ai"`, `"open-router"`, `"dify-ai"`, `"cal-com"`, `"elevenlabs"`, `"zendesk"`, `"nocodb"`, `"gmail"`, `"qr-code"`, `"posthog"`, `"segment"`, `"blink"`, `"chat-node"`.

### A. Cal.com (`"type": "cal-com"`)
Performs calendar scheduling actions like booking events.
```json
{
  "id": "block-id-cuid",
  "type": "cal-com",
  "options": {
    "action": "Book event",
    "link": "https://cal.com/username/event",
    "layout": "Month",
    "name": "{{First Name}}",
    "email": "{{Email}}",
    "saveBookedDateInVariableId": "var-booked-date-id"
  }
}
```

### B. Anthropic AI (`"type": "anthropic"`)
```json
{
  "id": "block-id-cuid",
  "type": "anthropic",
  "options": {
    "credentialsId": "anthropic-cred-id",
    "action": "Create message",
    "model": "claude-3-5-sonnet",
    "systemPrompt": "System instructions...",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### C. Zendesk (`"type": "zendesk"`)
Integrates with tickets or contacts.
```json
{
  "id": "block-id-cuid",
  "type": "zendesk",
  "options": {
    "credentialsId": "zendesk-cred-id",
    "action": "Create ticket",
    "subject": "Issue from chatbot",
    "comment": "User message: {{lastUserMessage}}"
  }
}
```

### D. Groq (`"type": "groq"`)
High-speed LLM inference.
```json
{
  "id": "block-id-cuid",
  "type": "groq",
  "options": {
    "credentialsId": "groq-cred-id",
    "action": "Create chat completion",
    "model": "llama3-8b-8192",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### E. ElevenLabs (`"type": "elevenlabs"`)
Generates voice speech from text.
```json
{
  "id": "block-id-cuid",
  "type": "elevenlabs",
  "options": {
    "credentialsId": "elevenlabs-cred-id",
    "action": "Text to speech",
    "text": "Hello, {{userName}}!",
    "voiceId": "voice-cuid",
    "saveAudioUrlInVariableId": "var-audio-url-id"
  }
}
```

### F. Deepseek (`"type": "deepseek"`)
```json
{
  "id": "block-id-cuid",
  "type": "deepseek",
  "options": {
    "credentialsId": "deepseek-cred-id",
    "action": "Create chat completion",
    "model": "deepseek-chat",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### G. Perplexity (`"type": "perplexity"`)
Search engine LLM assistant.
```json
{
  "id": "block-id-cuid",
  "type": "perplexity",
  "options": {
    "credentialsId": "perplexity-cred-id",
    "action": "Create chat completion",
    "model": "sonar-medium-online",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### H. OpenAI Forge (`"type": "openai"`) ⚠️ vs Legacy OpenAI
The **Forge** OpenAI block uses `"type": "openai"` (lowercase). This is **different** from the legacy built-in `"type": "OpenAI"` (uppercase) block in Section 4A.
Available actions: `"Create chat completion"`, `"Ask assistant"`, `"Ask model"`, `"Generate variables"`, `"Create speech"`, `"Create transcription"`.
```json
{
  "id": "block-id-cuid",
  "type": "openai",
  "options": {
    "credentialsId": "openai-cred-id",
    "action": "Create chat completion",
    "model": "gpt-4o",
    "messages": [
      { "role": "system", "content": "You are a helpful assistant." },
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "item": "Message content", "variableId": "var-reply-id" }
    ]
  }
}
```

### I. Mistral (`"type": "mistral"`)
Mistral AI chat completions. Actions: `"Create chat completion"`, `"Generate variables"`.
```json
{
  "id": "block-id-cuid",
  "type": "mistral",
  "options": {
    "credentialsId": "mistral-cred-id",
    "action": "Create chat completion",
    "model": "mistral-large-latest",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### J. Gmail (`"type": "gmail"`) _(beta)_
Sends emails via Gmail OAuth. Action: `"Send email"`.
```json
{
  "id": "block-id-cuid",
  "type": "gmail",
  "options": {
    "credentialsId": "gmail-cred-id",
    "action": "Send email",
    "recipients": ["{{recipientEmail}}"],
    "subject": "Message from {{First Name}}",
    "body": "{{messageContent}}"
  }
}
```

### K. NocoDB (`"type": "nocodb"`)
No-code database integration. Actions: `"Search records"`, `"Create record"`, `"Update existing record"`.
```json
{
  "id": "block-id-cuid",
  "type": "nocodb",
  "options": {
    "credentialsId": "nocodb-cred-id",
    "action": "Create record",
    "tableId": "md-table-cuid",
    "fields": [
      { "column": "Name", "value": "{{First Name}}" },
      { "column": "Email", "value": "{{Email}}" }
    ]
  }
}
```

### L. QR Code (`"type": "qr-code"`)
Generates QR code images from text/URLs. No credentials required. Action: `"Generate QR code image"`.
```json
{
  "id": "block-id-cuid",
  "type": "qr-code",
  "options": {
    "action": "Generate QR code image",
    "text": "{{websiteUrl}}",
    "saveUrlInVariableId": "var-qr-image-url-id"
  }
}
```

### M. OpenRouter (`"type": "open-router"`)
Routes LLM requests to many providers. Action: `"Create chat completion"`.
```json
{
  "id": "block-id-cuid",
  "type": "open-router",
  "options": {
    "credentialsId": "open-router-cred-id",
    "action": "Create chat completion",
    "model": "anthropic/claude-3.5-sonnet",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### N. Together AI (`"type": "together-ai"`)
Open-source model inference. Action: `"Create chat completion"`.
```json
{
  "id": "block-id-cuid",
  "type": "together-ai",
  "options": {
    "credentialsId": "together-ai-cred-id",
    "action": "Create chat completion",
    "model": "meta-llama/Llama-3-70b-chat-hf",
    "messages": [
      { "role": "user", "content": "{{lastUserMessage}}" }
    ],
    "responseMapping": [
      { "variableId": "var-reply-id" }
    ]
  }
}
```

### O. Dify.AI (`"type": "dify-ai"`)
Dify workflow/chatbot integration. Credentials required.
```json
{
  "id": "block-id-cuid",
  "type": "dify-ai",
  "options": {
    "credentialsId": "dify-ai-cred-id",
    "action": "Ask model"
  }
}
```

### P. Analytics Forge Blocks (Posthog, Segment)
- **Posthog** (`"type": "posthog"`): Tracks events in PostHog analytics.
- **Segment** (`"type": "segment"`): Tracks events in Segment.io analytics.

```json
{
  "id": "block-id-cuid",
  "type": "posthog",
  "options": {
    "credentialsId": "posthog-cred-id",
    "action": "Track event",
    "eventName": "Lead Captured",
    "distinctId": "{{Email}}"
  }
}
```
