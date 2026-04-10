#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${ROOT_DIR}/staging/upstream/google-gemma-4-e4b"
BASE_URL="https://huggingface.co/google/gemma-4-E4B/resolve/main"

mkdir -p "${TARGET_DIR}"

download_file() {
  local name="$1"
  local dest="${TARGET_DIR}/${name}"
  echo "Downloading ${name} -> ${dest}"
  curl -L --fail --retry 3 --output "${dest}" "${BASE_URL}/${name}"
}

download_file "README.md"
download_file "config.json"
download_file "generation_config.json"
download_file "processor_config.json"
download_file "tokenizer.json"
download_file "tokenizer_config.json"
download_file "model.safetensors"

echo "Official upstream base model staged in ${TARGET_DIR}"

