#!/usr/bin/env bash
# Called by semantic-release (@semantic-release/exec prepareCmd) with the next
# version: stamps it into both agents, then puts the release assets into dist/
# for @semantic-release/github to upload. install/agent.sh in llama-paddock
# downloads the Linux agent and its unit from them and checks them against
# SHA256SUMS. Asset names carry no version, so the releases/latest/download/
# links in the docs stay stable.
set -euo pipefail
version="$1"
cd "$(dirname "$0")/../.."

sed -i -E "s/^(const VERSION = \")[^\"]*(\";)/\1${version}\2/" \
  linux/paddock-agent.mjs windows/paddock-agent.mjs

rm -rf dist
mkdir -p dist/llama-paddock-agent-windows
cp linux/paddock-agent.mjs dist/paddock-agent-linux.mjs
cp linux/llama-paddock-agent.service dist/llama-paddock-agent.service
cp windows/paddock-agent.mjs dist/paddock-agent-windows.mjs
# The Windows installer copies the agent from its own folder, so it ships as a
# zip of the whole folder.
cp windows/paddock-agent.mjs windows/install.ps1 windows/uninstall.ps1 dist/llama-paddock-agent-windows/
(cd dist && zip -qr llama-paddock-agent-windows.zip llama-paddock-agent-windows)
(cd dist && sha256sum *.mjs *.service *.zip > SHA256SUMS)
