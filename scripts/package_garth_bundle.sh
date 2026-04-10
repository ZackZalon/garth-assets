#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="${ROOT_DIR}/staging/upstream/google-gemma-4-e4b"
BUNDLE_DIR="${ROOT_DIR}/bundle/garth-ai-preview"
MODEL_DIR="${BUNDLE_DIR}/model"

if [[ ! -f "${SOURCE_DIR}/model.safetensors" ]]; then
  echo "Missing upstream model.safetensors in ${SOURCE_DIR}"
  echo "Run scripts/download_official_base_model.sh first."
  exit 1
fi

rm -rf "${BUNDLE_DIR}"
mkdir -p "${MODEL_DIR}"

cp "${ROOT_DIR}/garth/garth-manifest.json" "${BUNDLE_DIR}/garth-manifest.json"
cp "${ROOT_DIR}/THIRD_PARTY_NOTICES.md" "${BUNDLE_DIR}/THIRD_PARTY_NOTICES.md"

cp "${SOURCE_DIR}/config.json" "${MODEL_DIR}/garth-config.json"
cp "${SOURCE_DIR}/generation_config.json" "${MODEL_DIR}/garth-generation-config.json"
cp "${SOURCE_DIR}/processor_config.json" "${MODEL_DIR}/garth-processor-config.json"
cp "${SOURCE_DIR}/tokenizer.json" "${MODEL_DIR}/garth-tokenizer.json"
cp "${SOURCE_DIR}/tokenizer_config.json" "${MODEL_DIR}/garth-tokenizer-config.json"
cp "${SOURCE_DIR}/model.safetensors" "${MODEL_DIR}/garth-model.safetensors"

echo "GARTH preview bundle created at ${BUNDLE_DIR}"
