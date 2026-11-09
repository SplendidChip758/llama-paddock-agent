#!/usr/bin/env bash
# Called by semantic-release (@semantic-release/exec prepareCmd) with the next
# version: stamps it into the agent, then puts the release assets into dist/
# for @semantic-release/github to upload. install/agent.sh in llama-paddock
# downloads the agent and its unit from them and checks them against
# SHA256SUMS. Asset names carry no version, so the releases/latest/download/
# links in the docs stay stable.
set -euo pipefail
version="$1"
cd "$(dirname "$0")/../.."

sed -i -E "s/^(const VERSION = \")[^\"]*(\";)/\1${version}\2/" linux/paddock-agent.mjs

rm -rf dist
mkdir -p dist
cp linux/paddock-agent.mjs dist/paddock-agent-linux.mjs
cp linux/llama-paddock-agent.service dist/llama-paddock-agent.service
(cd dist && sha256sum *.mjs *.service > SHA256SUMS)
