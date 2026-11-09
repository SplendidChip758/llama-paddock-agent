#!/usr/bin/env bash
# Called by semantic-release (@semantic-release/exec prepareCmd) with the next
# version: stamps it into the agent, then puts the release assets into dist/
# for @semantic-release/github to upload: the agent and its unit as one
# tarball, and SHA256SUMS. Asset names carry no version, so the
# releases/latest/download/ links in the docs stay stable.
#
# SHA256SUMS also lists the files inside the tarball. llama-paddock's
# install/agent.sh first fetches those files from this repository at the
# release's tag (raw.githubusercontent.com, which GitHub serves more reliably
# than release downloads) and checks them against these lines; the tarball is
# its fallback.
set -euo pipefail
version="$1"
cd "$(dirname "$0")/../.."

sed -i -E "s/^(const VERSION = \")[^\"]*(\";)/\1${version}\2/" linux/paddock-agent.mjs

rm -rf dist
mkdir -p dist/llama-paddock-agent
cp linux/paddock-agent.mjs linux/llama-paddock-agent.service dist/llama-paddock-agent/
tar -C dist --sort=name --owner=0 --group=0 --numeric-owner -czf dist/llama-paddock-agent-linux.tar.gz llama-paddock-agent
(cd dist && sha256sum llama-paddock-agent-linux.tar.gz llama-paddock-agent/paddock-agent.mjs llama-paddock-agent/llama-paddock-agent.service > SHA256SUMS)
