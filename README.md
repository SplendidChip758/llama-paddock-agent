<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="logo/banner-dark.svg">
    <img alt="llama-paddock-agent" src="logo/banner-light.svg" width="552">
  </picture>
</p>

<p align="center">
  <a href="https://github.com/SplendidChip758/llama-paddock-agent/releases/latest"><img alt="Latest release" src="https://img.shields.io/github/v/release/SplendidChip758/llama-paddock-agent?style=flat-square&color=0b7f62&label=release"></a>
  <a href="https://github.com/SplendidChip758/llama-paddock-agent/releases"><img alt="Latest prerelease" src="https://img.shields.io/github/v/release/SplendidChip758/llama-paddock-agent?include_prereleases&sort=semver&filter=*-dev*&style=flat-square&color=2563eb&label=prerelease"></a>
  <a href="LICENSE"><img alt="License: AGPL-3.0" src="https://img.shields.io/badge/license-AGPL--3.0-0b7f62?style=flat-square"></a>
  <a href="https://github.com/SplendidChip758/llama-paddock-agent/commits"><img alt="Last commit" src="https://img.shields.io/github/last-commit/SplendidChip758/llama-paddock-agent?style=flat-square"></a>
  <a href="https://github.com/SplendidChip758/llama-paddock-agent/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/SplendidChip758/llama-paddock-agent?style=flat-square"></a>
  <br>
  <a href="https://ollama.com"><img alt="Ollama" src="https://img.shields.io/badge/Ollama-compatible-151d29?style=flat-square&logo=ollama&logoColor=white"></a>
  <a href="#llama-paddock-agent"><img alt="Node.js" src="https://img.shields.io/badge/Node.js-%E2%89%A518.15-151d29?style=flat-square&logo=nodedotjs&logoColor=white"></a>
  <a href="#llama-paddock-agent"><img alt="No dependencies" src="https://img.shields.io/badge/dependencies-none-151d29?style=flat-square"></a>
  <a href="#install"><img alt="Platform: Linux" src="https://img.shields.io/badge/host-Linux-151d29?style=flat-square"></a>
  <a href="#versions-and-the-protocol"><img alt="Agent protocol 1" src="https://img.shields.io/badge/protocol-1-151d29?style=flat-square"></a>
</p>

<p align="center">
  <a href="https://llama-paddock.com">Website</a> ·
  <a href="#install">Install</a> ·
  <a href="https://github.com/SplendidChip758/llama-paddock/blob/main/docs/README.md">Documentation</a> ·
  <a href="https://github.com/SplendidChip758/llama-paddock">Dashboard</a> ·
  <a href="https://github.com/SplendidChip758/llama-paddock-win-agent">Windows agent</a> ·
  <a href="https://github.com/SplendidChip758/llama-paddock/blob/main/ROADMAP.md">Roadmap</a> ·
  <a href="https://github.com/SplendidChip758/llama-paddock/issues">Issues</a>
</p>

## llama-paddock agent

The Linux host agent for [llama-paddock](https://github.com/SplendidChip758/llama-paddock), a self-hosted dashboard for a fleet of Ollama hosts. It runs on each Linux Ollama host and gives the dashboard what Ollama's own API doesn't: system and GPU stats, Ollama's environment and service, its log, and the GPU check.

It runs as a root systemd service (`linux/llama-paddock-agent.service`) and is one file of plain Node.js (18.15+) with no dependencies, `linux/paddock-agent.mjs`. It serves its HTTP API on port 11435, over HTTPS with its own key and, unless turned off, plain HTTP.

For Windows PCs, use the [Windows agent](https://github.com/SplendidChip758/llama-paddock-win-agent): same API, its own repository and releases.

## Install

Install and update the agent as the [Linux agent docs](https://github.com/SplendidChip758/llama-paddock/blob/main/docs/agent-linux.md) describe, with the one-liner from llama-paddock's `install/agent.sh`. It downloads the agent from this repository's releases and checks it against `SHA256SUMS`.

Every release has `llama-paddock-agent-linux.tar.gz` (the agent and its systemd unit in `llama-paddock-agent/`) and `SHA256SUMS`, which lists the tarball and the files in it. The installer takes those files from this repository at the release's tag, checked against `SHA256SUMS`, and falls back to the tarball. Releases up to 0.10.0-dev.2 have `paddock-agent-linux.mjs` and `llama-paddock-agent.service` instead; up to 0.10.0-dev.1 also the Windows agent, which now releases from llama-paddock-win-agent.

## Versions and the protocol

The agent is released on its own, apart from the dashboard and the Windows agent, so a Linux-only fix ships without a new Windows agent. Its version says nothing about which dashboards it works with. That's the **protocol**: a whole number in `GET /health` and `GET /stats`, shared by both agents. It only goes up when the API changes in a way older dashboards can't follow, and each dashboard supports a range of protocols. See [Agent protocol](https://github.com/SplendidChip758/llama-paddock/blob/main/docs/api.md#agent-protocol) for the API and how the dashboard treats an agent outside its range.

Releases from `main` are stable (`vX.Y.Z`). Releases from `dev` are prereleases (`vX.Y.Z-dev.N`), installed with `PADDOCK_VERSION=dev`.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Issues and the roadmap live in [llama-paddock](https://github.com/SplendidChip758/llama-paddock/issues): open issues there, and reference them from here as `SplendidChip758/llama-paddock#N`.

Report security problems privately, as [SECURITY.md](SECURITY.md) describes.

## License

[AGPL-3.0](LICENSE), like llama-paddock.
