#!/usr/bin/env sh
set -eu

# This script generates code from Protocol Buffer definitions.
# It handles Go and TypeScript code generation and setup.

# --- Configuration ---
# Get the directory where the script is located to make paths absolute.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR}"

GO_PROTO_PATH="${PROJECT_ROOT}/gencode/go/yuxsr_dev_pb"
GO_MODULE_NAME="github.com/yushi-a/yuxsr-dev-pb/gencode/go/yuxsr_dev_pb"


# --- Functions ---

# Generates code from protobuf files using buf.
generate_proto() {
    echo "🔄 Generating code from protobuf definitions ..."
    if ! command -v npx >/dev/null 2>&1; then
        echo "❌ Error: npx is not installed. Please install Node.js and npm." >&2
        exit 1
    fi
    npx buf generate
    echo "✅ Protobuf code generation finished."
}

# Sets up the Go module for the generated code.
setup_go() {
    echo "🔄 Setting up Go module in ${GO_PROTO_PATH}..."
    # Use a subshell to avoid changing the script's current directory.
    (
        if ! command -v go >/dev/null 2>&1; then
            echo "❌ Error: go is not installed. Please install Go to continue." >&2
            exit 1
        fi
        cd "${GO_PROTO_PATH}"
        if [ ! -f "./go.mod" ]; then
            echo "ℹ️ go.mod not found. Initializing Go module..."
            go mod init "${GO_MODULE_NAME}"
        else
            echo "ℹ️ go.mod already exists. Skipping initialization."
        fi

        echo "🧹 Tidying Go module dependencies..."
        go mod tidy
    )
    echo "✅ Go module setup finished."
}

# Compiles TypeScript code.
compile_ts() {
    echo "🔄 Compiling TypeScript files using npx tsc..."
    if ! command -v npx >/dev/null 2>&1; then
        echo "❌ Error: npx is not installed. Please install Node.js and npm/yarn." >&2
        exit 1
    fi
    # npx will use the locally installed TypeScript compiler.
    npx tsc
    echo "✅ TypeScript compilation finished."
}

# --- Main Execution ---
main() {
    echo "🚀 Starting code generation process..."
    generate_proto
    setup_go
    compile_ts
    echo "🎉 Code generation process completed successfully!"
}

main
