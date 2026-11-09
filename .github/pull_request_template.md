<!--
PR title = the squash-merge commit = the changelog entry, so it must be a
Conventional Commit, e.g. "feat(linux): report the GPU's fan speed".
See CONTRIBUTING.md. Open PRs against `dev`, not `main`.
-->

## What and why

<!-- What does this change, and what problem does it solve? Reference issues as SplendidChip758/llama-paddock#123. -->

## Area

- [ ] Linux agent
- [ ] Windows agent
- [ ] CI / release
- [ ] Docs only

## How it was tested

<!-- What you ran and on what, e.g. "dry run on Ubuntu 24.04", "llama-paddock's scenario tests with PADDOCK_AGENT_SRC". -->

## Checklist

- [ ] PR title is a valid Conventional Commit
- [ ] Targets `dev` (or `main` for an urgent hotfix)
- [ ] `node --check` passes for both agents
- [ ] Both agents' API kept in step, and the simulated agent in llama-paddock updated if the API changed (PR: )
- [ ] `PROTOCOL` unchanged, or raised with the maintainer's agreement
- [ ] No tokens, passwords or personal hostnames/IPs in code, logs or screenshots
