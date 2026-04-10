#!/bin/zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="${ROOT_DIR}/staging/upstream/google-gemma-4-e4b"
BINARY_DIR="${ROOT_DIR}/staging/runtime/litert-lm/v0.10.1"
BUNDLE_DIR="${ROOT_DIR}/bundle/garth-ai-preview"
MODEL_DIR="${BUNDLE_DIR}/model"
RUNTIME_DIR="${BUNDLE_DIR}/runtime"

if [[ ! -f "${SOURCE_DIR}/model.safetensors" ]]; then
  echo "Missing upstream model.safetensors in ${SOURCE_DIR}"
  echo "Run scripts/download_official_base_model.sh first."
  exit 1
fi

rm -rf "${BUNDLE_DIR}"
mkdir -p "${MODEL_DIR}" "${RUNTIME_DIR}"

cp "${ROOT_DIR}/garth/garth-manifest.json" "${BUNDLE_DIR}/garth-manifest.json"
cp "${ROOT_DIR}/THIRD_PARTY_NOTICES.md" "${BUNDLE_DIR}/THIRD_PARTY_NOTICES.md"

cp "${SOURCE_DIR}/config.json" "${MODEL_DIR}/garth-config.json"
cp "${SOURCE_DIR}/generation_config.json" "${MODEL_DIR}/garth-generation-config.json"
cp "${SOURCE_DIR}/processor_config.json" "${MODEL_DIR}/garth-processor-config.json"
cp "${SOURCE_DIR}/tokenizer.json" "${MODEL_DIR}/garth-tokenizer.json"
cp "${SOURCE_DIR}/tokenizer_config.json" "${MODEL_DIR}/garth-tokenizer-config.json"
cp "${SOURCE_DIR}/model.safetensors" "${MODEL_DIR}/garth-model.safetensors"

copy_if_present() {
  local source_name="$1"
  local dest_name="$2"
  local source_path="${BINARY_DIR}/${source_name}"
  local dest_path="${RUNTIME_DIR}/${dest_name}"
  if [[ -f "${source_path}" ]]; then
    cp "${source_path}" "${dest_path}"
    if [[ "${dest_path}" != *.exe ]]; then
      chmod +x "${dest_path}"
    fi
  fi
}

copy_if_present "litert_lm_main.macos_arm64" "garth-engine.macos_arm64"
copy_if_present "lit_macos_arm64" "garth-tool.macos_arm64"
copy_if_present "litert_lm_main.windows_x86_64.exe" "garth-engine.windows_x86_64.exe"
copy_if_present "lit_windows_x86_64.exe" "garth-tool.windows_x86_64.exe"
copy_if_present "litert_lm_main.linux_x86_64" "garth-engine.linux_x86_64"
copy_if_present "lit_linux_x86_64" "garth-tool.linux_x86_64"

echo "GARTH preview bundle created at ${BUNDLE_DIR}"
