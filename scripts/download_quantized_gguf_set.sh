#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${ROOT_DIR}/staging/quantized/mradermacher-gemma-4-E4B-GGUF"
BASE_URL="https://huggingface.co/mradermacher/gemma-4-E4B-GGUF/resolve/main"

mkdir -p "${TARGET_DIR}"

MODEL_FILES=(
  "gemma-4-E4B.f16.gguf"
  "gemma-4-E4B.Q2_K.gguf"
  "gemma-4-E4B.Q3_K_S.gguf"
  "gemma-4-E4B.Q3_K_M.gguf"
  "gemma-4-E4B.Q3_K_L.gguf"
  "gemma-4-E4B.IQ4_XS.gguf"
  "gemma-4-E4B.Q4_K_S.gguf"
  "gemma-4-E4B.Q4_K_M.gguf"
  "gemma-4-E4B.Q5_K_S.gguf"
  "gemma-4-E4B.Q5_K_M.gguf"
  "gemma-4-E4B.Q6_K.gguf"
  "gemma-4-E4B.Q8_0.gguf"
)

download_file() {
  local name="$1"
  local dest="${TARGET_DIR}/${name}"
  echo "Downloading ${name} -> ${dest}"
  curl -L --fail --retry 3 -C - --output "${dest}" "${BASE_URL}/${name}"
}

for file in "${MODEL_FILES[@]}"; do
  download_file "${file}"
done

echo "Quantized GGUF comparison set staged in ${TARGET_DIR}"

