#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="v0.10.1"
TARGET_DIR="${ROOT_DIR}/staging/runtime/litert-lm/${VERSION}"
BASE_URL="https://github.com/google-ai-edge/LiteRT-LM/releases/download/${VERSION}"

mkdir -p "${TARGET_DIR}"

ASSETS=(
  "litert_lm_main.macos_arm64"
  "lit_macos_arm64"
  "litert_lm_main.windows_x86_64.exe"
  "lit_windows_x86_64.exe"
  "litert_lm_main.linux_x86_64"
  "lit_linux_x86_64"
)

download_file() {
  local name="$1"
  local dest="${TARGET_DIR}/${name}"
  echo "Downloading ${name} -> ${dest}"
  curl -L --fail --retry 3 -C - --output "${dest}" "${BASE_URL}/${name}"
  if [[ "${dest}" != *.exe ]]; then
    chmod +x "${dest}"
  fi
}

for asset in "${ASSETS[@]}"; do
  download_file "${asset}"
done

echo "LiteRT-LM runtime assets staged in ${TARGET_DIR}"
