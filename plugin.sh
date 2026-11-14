#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-systemone.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-systemone" ;;
    *) rel="x86_64-apple-darwin/gray-systemone" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-systemone" ;;
    *) rel="x86_64-unknown-linux-musl/gray-systemone" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-systemone.exe" "$here/target/release/gray-systemone" "$here/target/debug/gray-systemone.exe" "$here/target/debug/gray-systemone"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-systemone binary not found in $here" >&2
exit 1
