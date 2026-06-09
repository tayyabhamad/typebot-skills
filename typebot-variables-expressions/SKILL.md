---
name: typebot-variables-expressions
description: Validates and configures Typebot variable declarations and string interpolation expressions.
---

# Typebot Variables & Expression Syntax Manual

This skill covers the declaration of variables and string interpolation syntax in Typebot workflow configurations.

---

## 1. Root Variable Declaration
Every variable used in input collection, set-variable logic, or integrations MUST be declared in the root-level `"variables"` array of the Typebot JSON file.

### Schema
```json
"variables": [
  {
    "id": "var-unique-cuid",
    "name": "My Variable Name",
    "isSessionVariable": false
  }
]
```

### Properties
* `id` (string, required): A unique ID, typically a `cuid` (e.g. `clvqu4l5j00015bxibaf44slo`) or custom identifier.
* `name` (string, required): The human-readable name of the variable (e.g., `First Name`, `email`). Do not wrap in curly braces inside this declaration.
* `isSessionVariable` (boolean, optional): If `true`, the variable value persists across sessions/restarts if specified. Defaults to `false`.

---

## 2. Expression Interpolation Syntax
Variables are referenced inside other blocks by wrapping the variable's *exact name* (case-sensitive) in double curly braces: `{{Variable Name}}`.

### A. Inside Text Bubbles
Variables inside markdown or text content will be replaced by their value dynamically during chat execution:
```json
"children": [
  { "text": "Hello, {{First Name}}! Welcome back." }
]
```

### B. Inside URLs & API Payloads
Ensure variable expressions inside URLs or JSON strings are correctly formatted:
```json
{
  "url": "https://api.example.com/users/{{User ID}}/profile"
}
```

When inside a JSON body string (like inside a Webhook or HTTP request block), do not add manual quotes if the target value needs to be treated as a number or raw object, but wrap in escaped quotes `\"{{variable}}\"` if it's a string:
```json
"body": "{\n  \"username\": \"{{First Name}}\",\n  \"score\": {{User Score}}\n}"
```

### C. System Variables
Typebot exposes dynamic system variables. Standard system variables include:
* `{{lastUserMessage}}` / `{{User last message}}` (corresponds to the user's latest text input)
* `{{Assistant last message}}` (corresponds to the OpenAI / AI bubble's latest output message)

---

## 3. List & Array Variables
When pulling data from actions like Google Sheets "Get row" or DB searches, you can store columns as lists. Typebot variables can hold lists of strings.
* List variable reference: `{{My List Variable}}` will yield a comma-separated string representation of the array during interpolation.
* In Javascript code blocks, lists are treated as array objects: `let list = {{My List Variable}};`.
