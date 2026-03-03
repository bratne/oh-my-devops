#!/usr/bin/env bash
set -euxo pipefail

TOOLS_FILE="${1:-required_tools.yaml}"

if ! command -v yq >/dev/null 2>&1; then
  echo "ERROR: yq is required to parse $TOOLS_FILE"
  exit 1
fi

if [[ ! -f "$TOOLS_FILE" ]]; then
  echo "ERROR: $TOOLS_FILE not found"
  exit 1
fi

echo "Verifying required  tools from $TOOLS_FILE..."
echo

failures=0

count=$(yq '.tools | length' "$TOOLS_FILE")

for i in $(seq 0 $((count - 1))); do
  name=$(yq -r ".tools[$i].name" "$TOOLS_FILE")
  install_cmd=$(yq -r ".tools[$i].install" "$TOOLS_FILE")
  test_cmd=$(yq -r ".tools[$i].test" "$TOOLS_FILE")

  printf "Installing %-15s ... " "$name"

  cmd="${install_cmd:-}"
  if [[ -n "$cmd" && "$cmd" != "null" ]]; then
    sh -c "$cmd"
  fi

  printf "Testing %-15s ... " "$name"
  cmd="${test_cmd:-}"
  if [[ -n "$cmd" && "$cmd" != "null" ]]; then
    sh -c "$cmd"
  fi

#  if sh -c "$test_cmd" >/dev/null 2>&1; then
#    echo "OK"
#  else
#    echo "FAILED"
#    failures=$((failures + 1))
#  fi
done

# echo

# if [[ $failures -ne 0 ]]; then
#   echo "❌ $failures tool(s) failed verification."
#   exit 1
# fi

echo "✅ All tools verified successfully."
