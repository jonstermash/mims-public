# mims-public

A public collection of [Agent Skills](https://code.claude.com/docs/en/skills) — reusable instruction sets that extend what an AI assistant can do well — packaged as an installable plugin.

## Install

In Claude, go to **Settings → Plugins**:

1. **Add** → paste `jonstermash/mims-public`
2. **Browse** → find **Make It Make Sense** → install

Then invoke a skill by name — `/make-it-make-sense`, `/syco-killer`, or `/strategy-planner`. New skills added to the repo arrive automatically when you sync the marketplace.

<details>
<summary>Installing from the Claude Code CLI instead</summary>

```bash
/plugin marketplace add jonstermash/mims-public
/plugin install make-it-make-sense@mims-public
```

</details>

**Naming**, since the repo and the plugin differ:

| | |
|---|---|
| Repo / marketplace | `mims-public` — a container that can hold more over time |
| Plugin | `make-it-make-sense`, displayed as **Make It Make Sense** |
| Skills | `/make-it-make-sense`, `/syco-killer`, `/strategy-planner` |

> **Renamed in v1.0.0** from `jonstermash-skills`. The marketplace and plugin IDs changed, so existing installs must remove the old marketplace and re-add it with the command above. The skills themselves keep their names.

## Skills

| Skill | What it does |
|-------|--------------|
| [make-it-make-sense](./plugins/make-it-make-sense/skills/make-it-make-sense/) | Zoom out and simplify any written or presented output so it's understandable on the first pass. |
| [syco-killer](./plugins/make-it-make-sense/skills/syco-killer/) | Sycophancy as an accuracy failure, not a tone problem. Four gates on the drafted response: the Open, the Judgment, the Challenge, the Close. Calibration, not contrarianism. |
| [strategy-planner](./plugins/make-it-make-sense/skills/strategy-planner/) | Turn scattered research and notes into a strategy that guides decisions. Five stages — Goal, Objectives, Audiences, Messaging, Tactics — locked in order, with a protocol for reopening one when the evidence changes. |

### Turning on syco-killer

All three skills work as soon as they're installed — type `/make-it-make-sense`, `/syco-killer`, or `/strategy-planner`.

But `syco-killer` is the one skill that shouldn't wait to be summoned. A sycophantic response never feels sycophantic from the inside, so a skill that fires only when the model thinks it's relevant fires exactly never. To make it standing, paste one block into **Settings → Instructions for Claude**:

```
/syco-killer --standing
```

That prints the block. It's also in [`references/standing-rule.md`](./plugins/make-it-make-sense/skills/syco-killer/references/standing-rule.md), along with how to test that it's actually landing. Instructions for Claude loads every turn, ahead of the conversation — that's what makes the gate unconditional.

**Test it by behavior, not by asking.** Paste something mediocre and say "I wrote this and I think it's strong." Reflex praise means it isn't working. Asking the model whether the rule is loaded proves nothing, and a leading yes/no question is itself the vector you're testing for.

## Layout

This repo is **both the marketplace and the plugin**. The marketplace catalog points at one bundled plugin that ships all the skills:

```
mims-public/
├── .claude-plugin/
│   └── marketplace.json              # marketplace catalog (read by /plugin GUI)
├── plugins/
│   └── make-it-make-sense/
│       ├── .claude-plugin/
│       │   └── plugin.json           # plugin manifest
│       └── skills/
│           ├── make-it-make-sense/
│           │   ├── SKILL.md
│           │   └── references/       # loaded on demand, per pass
│           ├── syco-killer/
│           │   ├── SKILL.md
│           │   └── references/       # tells, outcome-honesty, standing-rule
│           └── strategy-planner/
│               ├── SKILL.md
│               ├── references/       # loaded per stage
│               └── assets/           # strategy doc + STATUS templates
└── README.md
```

## Adding a new skill

1. Create a new folder under `plugins/make-it-make-sense/skills/` named after the skill (kebab-case).
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`) followed by the instructions. Set `name` explicitly — without it, the invocation name falls back to the install directory, which for marketplace installs is a version string that changes on every update.
3. Bump `version` in both `.claude-plugin/marketplace.json` and `plugins/make-it-make-sense/.claude-plugin/plugin.json` so installs receive the update.
4. Add a row to the table above.
