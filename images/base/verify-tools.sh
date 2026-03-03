#!/usr/bin/env bash
set -euo pipefail

TOOLS_FILE="${1:-required_tools.yaml}"

if ! command -v yq >/dev/null 2>&1; then
  echo "ERROR: yq is required to parse $TOOLS_FILE"
  exit 1
fi

if [[ ! -f "$TOOLS_FILE" ]]; then
  echo "ERROR: $TOOLS_FILE not found"
  exit 1
fi

echo "Verifying required tools from $TOOLS_FILE..."
echo

failures=0

count=$(yq '.tools | length' "$TOOLS_FILE")

for i in $(seq 0 $((count - 1))); do
  name=$(jq -r ".tools[$i].name" "$TOOLS_FILE")
  test_cmd=$(jq -r ".tools[$i].test" "$TOOLS_FILE")

  printf "Checking %-15s ... " "$name"

  if sh -c "$test_cmd" >/dev/null 2>&1; then
    echo "OK"
  else
    echo "FAILED"
    failures=$((failures + 1))
  fi
done

echo

if [[ $failures -ne 0 ]]; then
  echo "❌ $failures tool(s) failed verification."
  exit 1
fi

echo "✅ All tools verified successfully."
