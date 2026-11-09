# Contributing

The Linux agent is part of [llama-paddock](https://github.com/SplendidChip758/llama-paddock), and its [Code of Conduct](https://github.com/SplendidChip758/llama-paddock/blob/main/CODE_OF_CONDUCT.md) applies here. Report security issues privately as described in [SECURITY.md](SECURITY.md).

Issues and the roadmap live in llama-paddock, on one tracker and one project. Open issues there, and reference them from commits and PRs here as `SplendidChip758/llama-paddock#N`.

The Windows agent has its own repository, [llama-paddock-win-agent](https://github.com/SplendidChip758/llama-paddock-win-agent), and its own releases.

## Local development

The agent is one file of plain Node.js (18.15+) with no dependencies. Run it without touching the system:

```bash
PADDOCK_AGENT_TOKEN=test PADDOCK_DRY_RUN=1 PADDOCK_AGENT_TLS_KEY=/tmp/agent.key PADDOCK_AGENT_TLS_CERT=/tmp/agent.crt \
  node linux/paddock-agent.mjs
curl -H "Authorization: Bearer test" localhost:11435/stats
```

`PADDOCK_DRY_RUN=1` never calls `systemctl` or `journalctl`.

Before pushing, run what CI runs:

```bash
node --check linux/paddock-agent.mjs
bash -n .github/scripts/prepare-release.sh
```

### Testing with the dashboard

llama-paddock's scenario tests run the dashboard against a released agent and compare it with its simulated agent (`test/sim/paddock-sim.mjs`, `test/scenarios/real-agent.test.mjs` there). To run them against your change, point them at your checkout:

```bash
cd ../llama-paddock/dashboard
npm run build
PADDOCK_AGENT_SRC=../../llama-paddock-agent npm run test:scenarios
```

When the API changes, change the simulated agent in llama-paddock and the Windows agent in llama-paddock-win-agent too, each in its own PR, and say in each PR which one to merge first.

## The rules

Read [AGENTS.md](AGENTS.md). In short: keep the HTTP API in step with the Windows agent, add fields and routes instead of changing existing ones, and bump `PROTOCOL` only for a change older dashboards can't follow, with the maintainer's agreement.

## Commit messages

Releases are fully automated: semantic-release reads every commit message to pick the next version. Read [.github/instructions/commit-message.instructions.md](.github/instructions/commit-message.instructions.md). In short:

- Conventional Commits: `<type>(<scope>): <summary>`.
- `feat` bumps the minor version and `fix`/`perf` the patch version. `docs`, `test`, `style`, `refactor`, `build`, `ci` and `chore` don't release.
- Never mark a change as breaking (`!`, `BREAKING CHANGE:`) unless the maintainer agrees.
- Never edit `CHANGELOG.md` or `VERSION` in the agent by hand.

## Branches and pull requests

Branch from `dev` and open the PR against `dev`; it is squash-merged, so its title becomes the changelog line. Merges to `dev` publish prereleases (`vX.Y.Z-dev.N`). `main` is stable and only receives `dev` when it ships, plus urgent hotfixes, with a merge commit. The release workflow merges `main` back into `dev` after a stable release.

## How a release happens

On a push to `main` or `dev` that changes the agent, the release workflow runs semantic-release (`.releaserc.json`). It stamps the version into the agent, updates `CHANGELOG.md`, tags the commit and publishes a GitHub release with `paddock-agent-linux.mjs`, `llama-paddock-agent.service` and `SHA256SUMS`. llama-paddock's `install/agent.sh` downloads from those releases and checks the files against `SHA256SUMS`.
