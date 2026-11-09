# llama-paddock agent

The host agents for [llama-paddock](https://github.com/SplendidChip758/llama-paddock), a self-hosted dashboard for a fleet of Ollama hosts. An agent runs on each Ollama host and gives the dashboard what Ollama's own API doesn't: system and GPU stats, Ollama's environment and service, its log, and the GPU check.

| Path | Runs as | Needs |
|---|---|---|
| `linux/paddock-agent.mjs` | systemd service (`linux/llama-paddock-agent.service`), as root | Node.js 18.15+ |
| `windows/paddock-agent.mjs` | Scheduled Task at logon, in your session (`windows/install.ps1`) | Node.js 18.15+ |

Each agent is one file of plain Node.js with no dependencies. Both serve the same HTTP API on port 11435, over HTTPS with their own key and, unless turned off, plain HTTP.

## Install

Install and update agents as the llama-paddock docs describe. The installers download them from this repository's releases:

- **Linux:** [Linux agent](https://github.com/SplendidChip758/llama-paddock/blob/main/docs/agent-linux.md), with the one-liner from llama-paddock's `install/agent.sh`
- **Windows:** [Windows agent](https://github.com/SplendidChip758/llama-paddock/blob/main/docs/agent-windows.md), from `llama-paddock-agent-windows.zip` in the [latest release](https://github.com/SplendidChip758/llama-paddock-agent/releases/latest)

Every release has `paddock-agent-linux.mjs`, `llama-paddock-agent.service`, `paddock-agent-windows.mjs`, `llama-paddock-agent-windows.zip` and `SHA256SUMS`.

## Versions and the protocol

Agents are released on their own, so an agent's version says nothing about which dashboards it works with. That's the **protocol**: a whole number in `GET /health` and `GET /stats`. It only goes up when the API changes in a way older dashboards can't follow, and each dashboard supports a range of protocols. See [Agent protocol](https://github.com/SplendidChip758/llama-paddock/blob/main/docs/api.md#agent-protocol) for the API and how the dashboard treats an agent outside its range.

Releases from `main` are stable (`vX.Y.Z`). Releases from `dev` are prereleases (`vX.Y.Z-dev.N`), installed with `PADDOCK_VERSION=dev`.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Issues and the roadmap live in [llama-paddock](https://github.com/SplendidChip758/llama-paddock/issues): open issues there, and reference them from here as `SplendidChip758/llama-paddock#N`.

Report security problems privately, as [SECURITY.md](SECURITY.md) describes.

## License

[AGPL-3.0](LICENSE), like llama-paddock.
