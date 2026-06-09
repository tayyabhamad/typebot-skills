#!/bin/bash
# Simple builder & validation script for Typebot expert skills

echo "🔍 Validating Typebot AI Expert Skills..."

SKILLS=(
  "typebot-compiler"
  "typebot-block-configuration"
  "typebot-variables-expressions"
  "typebot-routing-edges"
  "typebot-schema-sync"
  "typebot-scripting-code"
)

errors=0

for skill in "${SKILLS[@]}"; do
  file="skills/$skill/SKILL.md"
  if [ -f "$file" ]; then
    echo "✅ Checked: $file"
  else
    echo "❌ Missing: $file"
    errors=$((errors+1))
  fi
done

if [ $errors -eq 0 ]; then
  echo "🎉 All Typebot skills are valid and verified!"
  exit 0
else
  echo "⚠️ Build failed: $errors skill(s) missing or incorrect."
  exit 1
fi
