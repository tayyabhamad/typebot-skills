---
name: typebot-scripting-code
description: Guidelines and execution patterns for writing custom JavaScript inside Typebot 'Code' script blocks.
---

# Typebot Scripting & Code Blocks Manual

This skill covers writing custom Javascript logic in Typebot's `"type": "Code"` blocks.

---

## 1. How the Script Runtime Works
Typebot executes code inside an isolated JavaScript VM environment.
* **Text Preprocessing:** Before executing the script, Typebot parses the code string and replaces all `{{Variable Name}}` expressions with their internal `id` values.
* **Global Injection:** The engine injects each variable into the VM's global scope using its `id` as the key and its current value as the value.

---

## 2. Reading Variables
Because of the text preprocessing, you can refer to variables in two ways:

### A. Raw Variable Reference (Recommended for Numbers & Objects)
Write the variable wrapped in double curly braces without quotes. The preprocessor replaces it with the global variable's identifier:
```javascript
let currentScore = {{User Score}};
let doubleScore = currentScore * 2;
```
If `{{User Score}}` evaluates to ID `var-score-1`, the executed script becomes:
```javascript
let currentScore = var-score-1; 
let doubleScore = currentScore * 2;
```

### B. String Template Reference (Recommended for Strings)
If the variable is a string, wrap the expression in string quotes so the replacement evaluates to a valid string literal:
```javascript
let email = "{{User Email}}";
if (email.endsWith("@company.com")) {
  // logic...
}
```

---

## 3. Writing / Modifying Variables (`setVariable`)
You cannot reassign variables directly (e.g. `{{User Score}} = 10;` is invalid because it expands to `var-score-1 = 10;` which is a read-only variable assignment).

Instead, you must use the globally injected helper function `setVariable`:
```javascript
setVariable("Variable Name", newValue);
```

### Example: Incrementing a Score
```javascript
let currentScore = {{User Score}} || 0;
setVariable("User Score", currentScore + 1);
```

---

## 4. Performing Fetch Requests
Typebot supports a customized, safe global `fetch` API inside the sandbox to call APIs from scripts:
```javascript
const responseText = await fetch("https://api.github.com/repos/typebot-io/typebot", {
  headers: { "User-Agent": "Typebot-Script" }
});
const data = JSON.parse(responseText);
setVariable("Repository Stars", data.stargazers_count);
```
> [!NOTE]  
> The `fetch` function returns the response **body string directly** (not a response object). You must use `JSON.parse()` on the returned string to inspect json objects.
