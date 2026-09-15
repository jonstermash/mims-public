# CLAUDE.md

Working notes for this repo. Read before editing anything under `plugins/`.

## What this repo is

`mims-public` is both a marketplace and a plugin. `.claude-plugin/marketplace.json` is the catalog the `/plugin` GUI reads; it points at one bundled plugin, `make-it-make-sense`, which ships all the skills and one hook.

```
mims-public/
├── .claude-plugin/marketplace.json          # marketplace catalog
├── .github/workflows/checks.yml             # runs scripts/check-repo.sh on push and PR
├── plugins/make-it-make-sense/
│   ├── .claude-plugin/plugin.json           # plugin manifest
│   ├── BUILD                                # generated build stamp — never hand-edit
│   ├── hooks/                               # hooks.json + syco-killer.sh (UserPromptSubmit)
│   └── skills/<skill-name>/
│       ├── SKILL.md
│       └── references/                      # loaded on demand
├── scripts/
│   ├── check-repo.sh                        # the release invariants below, enforced
│   └── stamp-build.sh                       # writes and verifies BUILD
├── docs/design/
├── CHANGELOG.md
└── README.md
```

No test suite and no dependencies. Everything shipped is markdown, JSON, and one bash hook. The only build step is the stamp below.

**Run `scripts/check-repo.sh` before you commit.** It enforces the rules in the next section, and CI runs the same script on every push and PR. It needs nothing but bash and python3.

## Rules that break installs if you miss them

**Set `name:` explicitly in every SKILL.md frontmatter.** Without it the invocation name falls back to the install directory, which for marketplace installs is a version string that changes on every update. The skill silently becomes uninvocable.

**Bump `version` in all four places, together.** `marketplace.json`, `plugin.json`, `BUILD`, and the `CHANGELOG.md` heading. Bump only some and existing installs never receive the update — the `/plugin` GUI reads the catalog, so a release that skips `marketplace.json` ships to nobody. This has already been lost once, in `79e2728`. `check-repo.sh` fails on any disagreement.

**Re-stamp `BUILD` whenever a shipped plugin file changes.** `scripts/stamp-build.sh` records the version and a content hash over the plugin tree, and the hook prints that line into context on every prompt. Skip the re-stamp and every running session reports a build that isn't the one it's running. `BUILD` is generated; edit the script, never the stamp.

Note what `stamp-build.sh --check` does *not* cover: it hashes only files inside the plugin directory, so `marketplace.json` is invisible to it. It passes clean on a version mismatch. That gap is why `check-repo.sh` exists.

**Don't rename the marketplace or plugin IDs.** The v1.0.0 rename from `jonstermash-skills` forced every existing install to remove and re-add the marketplace. Treat the IDs as frozen.

## Adding a skill

1. New folder under `plugins/make-it-make-sense/skills/`, kebab-case.
2. `SKILL.md` with YAML frontmatter (`name`, `description`) then the instructions. `name` must match the folder.
3. Bump `version` in both manifests.
4. Add a `CHANGELOG.md` entry under a new `## [x.y.z]` heading.
5. Run `scripts/stamp-build.sh`.
6. Add a row to the skills table in `README.md`.
7. Run `scripts/check-repo.sh` and confirm it passes.

## What CI checks

`.github/workflows/checks.yml` runs `scripts/check-repo.sh` on every push and pull request. Five checks, all errors that fail the build:

| Check | Catches |
|---|---|
| Manifests parse | A malformed JSON manifest, which takes the marketplace down entirely |
| Version parity | The four version sources disagreeing — the `79e2728` failure |
| Stamp integrity | A shipped file edited without re-stamping `BUILD` |
| Skill `name:` | A missing or mismatched `name:`, which makes the skill silently uninvocable |
| Version moved | A shipped file edited at an unchanged version — four sources agreeing on a number that never moved, so the release reaches nobody |

Parity and movement are different failures. Parity catches the sources disagreeing; movement catches them agreeing on a stale number. Re-stamping keeps `BUILD` consistent with the edit, so a release that skips the bump passes both of the older checks on its way to nowhere.

**The shipped set** is everything under `plugins/make-it-make-sense/` plus `marketplace.json`, minus `BUILD` — a re-stamp that changes only the timestamp line isn't a release. Edits to `scripts/`, `.github/`, `CLAUDE.md`, or `README.md` don't require a bump; nothing an install fetches has changed. Record those under a `## [Unreleased]` heading in `CHANGELOG.md`, which the parity check skips because it only reads `## [x.y.z]`.

**The baseline** is the last released state: the PR's base branch, the previous commit when you're on `main` with a clean tree, or `main` itself when you have uncommitted edits. Override it with `BASELINE_REF=<ref>`. The check compares against the working tree, so it fires before you commit — including on files you haven't `git add`ed yet, which is what a new skill folder looks like. When no baseline resolves (shallow clone, no git) it warns and skips rather than failing; the workflow therefore checks out with `fetch-depth: 0`, without which the check would quietly pass having compared nothing.

Description length warns but does not fail — see the note in the script.

The workflow is a thin wrapper: it checks out the repo and calls the script. Add checks to `check-repo.sh`, not to the YAML, so they stay runnable by hand. The one thing the YAML must carry is checkout depth, since a check can't fetch the history it was denied.

## Writing a SKILL.md

The house pattern, visible in both existing skills:

- **The description is the trigger.** It's what the model reads when deciding whether to fire, so it carries the cues, the default posture, and the "when in doubt" instruction — not just a summary of what the skill does. Combined `description` and `when_to_use` text is truncated in the skill listing at 1,536 characters — a configurable default (`skillListingMaxDescChars`), not a hard limit, and overflow is silent rather than an error. `check-repo.sh` warns past it and doesn't fail. Both current descriptions sit near 1,015. Don't re-enact the v0.4.0 mistake of enforcing a cap the tooling never imposed.
- **SKILL.md is self-sufficient.** Tell-lists, examples, and edge cases live in `references/` and load on demand, but the skill's checks must fire from SKILL.md alone. A check that needs a reference open is a check that doesn't run.
- **Moves state in one line each,** with the reference file named inline where the detail lives.
- **Procedures beat rule-lists.** A skill that reads as fifteen loose rules gets partially applied; a skill that reads as ordered passes with a gate at the end of each gets run.

## Editing prose in this repo

Skills, README, and CHANGELOG are all read by people deciding whether to install something. Run `/make-it-make-sense` over any substantial prose edit before committing.
