# Changelog

All notable changes to this project are recorded here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); this project uses
[semantic versioning](https://semver.org/).

## [1.9.0]

### Changed
- **`mims-strategy-planner` is now `strategy-planner`.** The prefix repeated what the marketplace
  already says — every skill here ships from `mims-public`, so carrying it in one skill's
  invocation name marked nothing. Invoke it as `/strategy-planner`. The 1.8.0 name was live for
  minutes, so this breaks nobody in practice, but it is a rename of the invocation surface rather
  than a fix, which is why it takes a minor bump. The directory, the `name:` in frontmatter, both
  manifest descriptions, and the README all move together — a `name:` that disagrees with its
  directory fails `check-repo.sh`, and a stale README teaches the wrong command.

## [1.8.0]

### Added
- **`mims-strategy-planner`: a third skill.** A top-down cascade — Goal → Objectives → Audiences →
  Messaging → Tactics — run in order, each stage grounded in tagged evidence and locked with an
  owner and a date before the next one opens. It exists because the usual failure isn't a missing
  idea, it's a tactic list nobody can trace back to a decision: the Stage 5 coverage check reads
  the tactic map both ways, so an audience with no tactic and a tactic with no audience are both
  visible rather than merely absent.
- **A way back up the cascade.** Locks that can't be reopened get ignored the first time evidence
  contradicts them. "Reopening a locked stage" names the triggers, unlocks only the highest stage
  the evidence actually breaks, marks what's below it under review instead of deleting it, and
  logs who decided. A single data point is grounds to investigate, not to unlock.
- **Five references and two doc templates.** `confidence-tags.md`, `messaging-by-audience-type.md`,
  `expansion-ladder.md`, `asset-qa.md`, and `persona-review.md` load at the stage that needs them;
  `assets/strategy-doc-template.md` and `assets/status-template.md` are copied at the start of a
  run. The STATUS doc is what makes a run survive a context reset — a multi-session strategy that
  lives in chat history is a strategy you get to rebuild from memory.

### Changed
- **Both manifests name three skills,** and the plugin keywords now cover strategy, positioning,
  and messaging.

## [1.7.0]

### Fixed
- **The Structure gate was selecting for the failure it was meant to catch.** Literal headings —
  "Why the migration slipped from June to August," "What this means for the onboarding team" — kept
  surviving the pass, and the reason was the gate itself, not a missing anti-pattern. It asked that
  the headings "tell the story on their own." Run a clean categorical outline through that test
  (Scope · Method · Findings · Limitations · Cost) and it **fails** — those name the shape, not the
  story. Run a fully literal one through it ("We tested 40 accounts over six weeks," "Churn traces
  to pricing, not onboarding," …) and it **passes**: distinct, no colons, no filler, no orphaned
  pronouns, and it tells the story completely. Every run of the pass therefore pushed headings
  toward carrying more content, which is the same axis as more literal. Adding a tenth anti-pattern
  would not have helped, because the gate closes the pass and the gate is what actually runs.

### Changed
- **Headings now default to a categorical noun phrase.** The Pass 2 move is restated: a heading
  names what the section is *about*, not a sentence restating what it *says* — "Method," not "What
  we measured"; "Rollback plan," not "How we'd back this out if it fails." The reasoning is what a
  heading is for. The reader navigates by it, which wants a short stable address; a heading that
  delivers the content makes them read it twice and turns the outline into a summary, which is the
  one thing a table of contents must not be.
- **The claim heading is now the deliberate exception, not a co-equal branch.** It stays legal and
  stays right where the heading may be the only thing read — a slide, an email subject, a report's
  single headline finding — and it must still be paid off by its body. What changed is that you
  reach for it on purpose rather than drifting into it. An outline that is entirely claims has
  stopped being an outline. The old framing routed by content type (reference → label, argument →
  claim), which classified literal headings into the argument branch and waved them through.
- **The gate, rewritten.** The outline must read as an **index, not a summary**: each heading names
  its own subject, none restates its section's opening line, any claim heading is deliberate and
  paid off, and each is specific enough that it could not sit unchanged over someone else's
  document on another topic. The last criterion replaces the load the old "tell the story" test was
  carrying — it still rejects a vacuous outline, without rewarding a literal one.

### Added
- **`references/titles.md` names the literal heading directly,** with two tests: does the heading
  carry a **finite verb** ("Why the migration *slipped*," "What this *means*") — a categorical
  heading is a noun phrase, so the verb is the tell — and does it **restate the section's first
  sentence**, which is the significance coda in miniature, at the top instead of the bottom. The
  fix is usually a shorter noun phrase already inside the heading: "How the cache invalidation
  actually works" → "Cache invalidation."
- **"Categorical is not vague," stated explicitly.** "Overview," "Background," "Next Steps," "Other
  Considerations" are categorical *and* interchangeable. The default is the shortest noun phrase
  still specific to this piece. The `Zero tension` anti-pattern is renamed `Generic` accordingly —
  its old wording asked headings to create *curiosity*, which pushed toward the teaser the same
  page rejects elsewhere.

### Notes
- **Two anti-patterns were revised, not just added to.** `Zero tension` and `Throat-clearing` both
  told the reader to replace a weak heading with "the point" or "the verdict or claim the section
  delivers." Left alone they would have contradicted the new default on the same page. They now
  point at the subject instead.
- **Rule-reference files keep their imperative headings.** `titles.md`, `framing-tells.md`, and
  `quant-claims.md` head each rule with the rule itself ("Cut defensive framing," "Define by
  essence, not example"). That is the deliberate-exception case, applied consistently: in a list of
  rules the heading *is* the content, and the outline is meant to read as the ruleset. Not an
  oversight, and not a licence to write memo headings that way.

## [1.6.0]

### Added
- **`make-it-make-sense` now catches the appeal to authority that names nothing.** A new Pass 1 ·
  Substance move, **Name the source or drop the appeal**, targets the state sitting between a real
  anchor and no anchor: "studies show," "industry best practice," "as many have noted," "research
  suggests." It survives every check the skill already ran. A fabrication sweep hunts for specifics
  that turn out to be false, and this has no specific to falsify — it borrows the *shape* of
  evidence without the content, and the reader grants it the credibility of a citation anyway. Two
  fixes, in order: name the source, or drop the appeal and make the claim on its own authority,
  which is honest because it was yours all along. The softened variant — "it's generally accepted,"
  "the consensus seems to be" — is the same move wearing a hedge that makes it feel more careful
  and less checkable. Tell-list in `references/framing-tells.md`.
- **The significance coda, on Pass 2's usual-offenders list.** A closing passage that explains what
  the piece *meant*, restating the point it already made and adding a moral to it. The redundancy
  sweep already covered the neighbouring cases — an intro restating the summary, a "next steps"
  repeating the recommendation — but not this one. Note the inversion, which is why it needs saying:
  leading with the answer is the rule; stating it a second time as a lesson is the failure.
- **Causal tidiness, as a `references/quant-claims.md` tell.** The drafting-side view of
  causation-vs-correlation: a draft reaches for one cause where the evidence supports several,
  because a single clean chain reads better than a tangle. The tell is that every contributing
  factor has been resolved into the one the author acted on — nothing left over, nothing competing.
  When a causal chain has no loose ends, the loose ends were cut. Includes the related ending
  failure: a piece that resolves on a feeling ("the team is now aligned") rather than a decision.

### Notes
- **Source, and what was deliberately not taken from it.** These three come from Russell et al.,
  *StoryScope: Investigating idiosyncrasies in AI fiction* (2026, preprint) — a study finding that
  discourse-level narrative features alone separate human from AI fiction at 93.2% macro-F1, with no
  stylistic signals, over 61,608 stories. The human corpus is published short fiction (Books3), not
  amateur writing, so the contrast is professional prose against LLM output.

  What transferred is three specific reflexes with clean non-fiction analogues. What did **not**:
  the detection framing and the headline number, which are a measurement result, not an editing
  target; the per-model fingerprints (flat event escalation, dream sequences), which are
  unactionable per-artifact and stale by the next release; and the fiction-craft findings —
  temporal complexity, moral ambiguity, unresolved endings — which are virtues in a story and
  defects in a memo. Optimizing a status update toward non-linear time would be worse writing for
  that reader. The paper is evidence that the Premise's convergence claim is real and
  model-general; it is not a style to copy.
- **No new pass, and no description change.** All three land inside the existing passes and fire
  from their gates. The frontmatter trigger cues already cover the cases, and both skill
  descriptions sit near 1,015 of the 1,536 listing budget — headroom, not a reason to spend it.

## [1.5.1]

No skill content changed in this release. It ships the delivery fix that 1.5.0 needed and the
checks that stop it recurring.

### Fixed
- **1.5.0 shipped to nobody.** `79e2728` bumped `plugin.json`, `BUILD`, and this changelog to 1.5.0
  and left `.claude-plugin/marketplace.json` on 1.4.0. The `/plugin` GUI reads the **catalog**, so
  the version users are offered came from the one file that didn't move: the "grade on the gap"
  work was committed, tagged in the changelog, and undelivered for two commits. Anyone who synced
  the marketplace in that window was told they were current while running a build without it. The
  catalog is corrected and this release carries all four sources forward together.

### Added
- **The release invariants are now enforced instead of remembered.**
  `.github/workflows/checks.yml` runs `scripts/check-repo.sh` on every push and pull request — the
  repo's first CI. Four checks, each mapped to a way an install has broken or can break silently:
  the manifests parse as JSON; the four version sources agree; `BUILD` matches the plugin tree; and
  every `SKILL.md` declares an explicit `name:` matching its directory. Verified against the tree at
  `79e2728` — the check fails it, which is the whole point of writing it.
- **The checks are a script, not YAML.** The workflow checks out the repo and calls
  `scripts/check-repo.sh`; all logic lives in the script so it runs by hand before committing. A
  check that exists only in CI is one you find out about after you've pushed. It needs nothing but
  bash and python3.
- **`CLAUDE.md`** — working notes for anyone editing the repo: the install-breaking rules, the house
  `SKILL.md` pattern, and what CI covers.

### Notes
- **Description length warns; it does not fail the build.** 1,536 is the documented default for
  combined `description` and `when_to_use` text, it's configurable via `skillListingMaxDescChars`,
  and overflow is silent truncation in the listing rather than an error. Gating on it would re-enact
  the v0.4.0 mistake of enforcing a cap the tooling never imposed — a number this project already
  spent a release retiring.
- **Why `stamp-build.sh --check` couldn't have caught this.** It hashes exactly the files inside the
  plugin directory, and `marketplace.json` sits outside that set, so it reports OK on a version
  mismatch. That isn't a bug in the stamp — the catalog was never in its remit — but it does mean
  the stamp check and the parity check cover different failures, and only one of them existed.
- **`## [Unreleased]` is tolerated** by the parity check: it skips non-semver headings and reads the
  first version below. This project has never used one, and the check doesn't require starting.

## [1.5.0]

### Added
- **`make-it-make-sense` now catches the verdict that its own caveat revokes.** A new Pass 1 ·
  Substance move, **Grade on the gap, not around it**, targets a shape AI output produces
  constantly: a pass verdict trailed by a disqualifying qualifier — "our spec was right, with one
  real gap." Plainly, it's *this car runs, but it doesn't have wheels.* The framing is a substance
  failure rather than a tone one, because the reader takes their action from the verdict and skims
  the qualifier, so a "pass" headline over a "fail" body routes the decision wrong while appearing
  to have disclosed everything. The test is whether the two halves imply the same next action —
  ship vs. hold, approve vs. rework. If they diverge, the caveat *is* the verdict. The fix is a
  reorder, not a cut: both facts survive, and what passed stops being the lead.
- **The same rule, pointed at severity ratings.** Bug lists and audit findings produce a variant
  where the headline isn't "pass" but "low priority": "it fails cleanly and writes nothing, so it's
  much less urgent than #1 — but it blocks importing for any UPC the tenant hasn't used before."
  Two moves stack there. The item is **graded on its failure mode instead of its consequence** —
  "fails cleanly" answers *will this corrupt data?*, a real question, but not the one that sets
  priority — and its severity is stated **by comparison** to another finding, when being less bad
  than the worst item on a list is not the same as not blocking. Failing safe belongs in the line
  about fixing the thing, never in the line about how much it matters. Watch the scope label too:
  "any UPC the tenant hasn't used before" is every new product, i.e. the main path described as an
  edge case.
- **A gate that actually fires.** Pass 1's gate now requires that a reader who acted on the
  one-line takeaway alone, having read none of the caveats, would still do the right thing. If any
  caveat would change their action, the takeaway is **wrong**, not merely incomplete. Per this
  project's standing convention, the gate fires from `SKILL.md` without the reference open; the
  tell-lists, both worked examples, and the seam with `syco-killer` Gate 2 live in
  `references/framing-tells.md`.

### Notes
- The seam with `syco-killer` is deliberate and not a duplicate. Gate 2's "say the disqualifying
  thing early" governs *where bad news sits in a conversation*; this governs *the verdict itself in
  an artifact*. Moving the gap up front doesn't help if the headline still reads "pass."

## [1.4.0]

### Added
- **Build stamp, so a loaded build can identify itself.** `scripts/stamp-build.sh` writes
  `plugins/make-it-make-sense/BUILD` with a version, a content hash, a source commit, and a UTC
  build time. Version strings are hand-typed, so a build where a skill changed but the version
  didn't is byte-different and version-identical — indistinguishable from inside a session. The
  content hash covers every file in the plugin directory **except** `BUILD` itself, which is what
  makes it well-defined rather than circular, and `--check` recomputes it from any checkout.
  `source_commit` is honestly labelled as the *parent* of the commit carrying the stamp: writing
  the stamp changes the tree, so a commit cannot record its own SHA. Use the content hash to prove
  identity; the SHA is advisory.
- **Three ways to read the build from a running session.** Tier 1: the hook prints one build line
  on every prompt, which lands in context with zero tool calls. Tier 2: `cat BUILD` at the synced
  plugin root. Tier 3 is **not implemented** — see below.

### Changed
- **The hook returns to production posture.** The v1.3.0 verification build was deliberately
  unconditional, wrote logs to three paths, and emitted a large block. Its question is answered.
  The arming gate is back, the logging is gone, and it now emits one build line always plus the
  compressed gate only while armed.
- **Container detection fixed.** The old heuristic tested for Docker (`/.dockerenv`, cgroup
  markers) and so reported `container=no` in Cowork, which runs a **Firecracker microVM** — both
  checks miss by design. It now tests for virtualization, keying on the `-fc-` tag in the kernel
  release that the Cowork session actually reported. Behind `SYCO_DEBUG=1`, since it costs context
  on every prompt and its question is now settled.

### Fixed
- **The description cap enforced since v0.4.0 was wrong.** This project trimmed skill descriptions
  to stay under **1,024** characters. The documented cap is **1,536** — "the combined `description`
  and `when_to_use` text is truncated at 1,536 characters in the skill listing to reduce context
  usage" — and it's configurable via `skillListingMaxDescChars`, so 1,536 is a default rather than
  a floor. Overflow is silent truncation in the listing, not an error, so the risk was real; the
  number was not. Both descriptions sit near 1,015 and were never close to the true limit.
  Nothing in the repo enforced 1,024 mechanically — it lived in the v0.4.0 changelog entry and in
  habit. The entry now carries a correction and the number is retired. **Descriptions are
  deliberately not re-expanded in this release**; this change stops enforcing a false constraint,
  it doesn't spend the headroom.
- **The v1.2.0 changelog entry was wrong, and it misled real decisions.** See the note added there.

### Decided (recorded so they don't get reopened)
- **`when_to_use`: not adopted.** It would be the natural home for trigger cues and would free
  description space, but there are two frontmatter schemas — Claude Code local and plugin skills
  accept all documented fields, while the claude.ai upload / Skills API / packaging path accepts
  exactly six (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`) and
  **hard-errors on unknown fields**. `when_to_use` is not among the six, and which validator runs on
  the GitHub-marketplace → Cowork → synced path is undocumented. Not worth an unknown-schema risk
  for a convenience.
- **`version:` in frontmatter: closed permanently.** Same reason, but worse — it would hard-error on
  the spec path. Not "untested." Not to be revisited.
- **Tier 3 (skill-level build stamp): abandoned.** The only documented carrier is `metadata`, which
  Claude Code explicitly "doesn't act on," so it never reaches model context and reading it requires
  a file read — which is Tier 2. Tier 3 collapsed into Tier 2 and added nothing.

### How to check which build is loaded
- Run `scripts/stamp-build.sh` here and note the `content_hash` it prints. Start a new Cowork
  session and read the hook's stamp line, which carries the same hash. If they match, the build you
  published is the build that is running. Compare by eye; no harness needed.
- **The hash is the only field that proves it.** The semver is hand-typed, and the sync layer's own
  counter and timestamps move whenever a sync runs, whether or not the content changed. Only the
  content hash is derived from the bytes.

### Changed — stamp checking
- **Drift and unexpected files are now different findings.** The stamp records the exact **file set**
  it hashed, so `--check` hashes that set rather than "whatever is in the directory." A recorded file
  that is missing or whose bytes changed is **DRIFT** and exits non-zero; a file that appears later is
  **UNEXPECTED** and is reported without failing. This matters because a plugin can write into its own
  root at runtime — pre-1.4.0 hooks wrote `hook-fired.log` there — and the naive approach would have
  read that as content drift forever. Known runtime-written paths are excluded outright and named.
  Measured, not assumed: the sync layer adds nothing, strips nothing, and preserves the executable
  bit, so drift points at the payload rather than the transport.

## [1.3.0]

### Added
- **The `UserPromptSubmit` hook, restored as a verification build.** v1.2.0 removed it on the
  belief that hooks don't run outside the Claude Code CLI. This build was deliberately
  unconditional — no arming gate, since an unarmed hook and a dead hook are indistinguishable from
  outside — and emitted a sentinel plus a host/kernel/container fingerprint to settle the question
  empirically.

### Result
- **Hooks fire in Cowork. Confirmed.** A plugin-declared `UserPromptSubmit` hook executes in
  Cowork's cloud container *and* its stdout reaches the model's context. Observed: `host=vm`,
  `user=root`, `kernel=Linux 6.18.5-fc-v20`,
  `plugin_root=/root/.claude/plugins/synced/make-it-make-sense`. This settles
  [anthropics/claude-code#47993](https://github.com/anthropics/claude-code/issues/47993) and
  [#45514](https://github.com/anthropics/claude-code/issues/45514) for this surface.
- The fingerprint also showed `container=no`, which was the heuristic being wrong rather than the
  environment being bare metal — corrected in 1.4.0.

## [1.2.0]

### Removed
- **The `UserPromptSubmit` hook.** It was the centerpiece of v1.0.0 and it never functioned in the
  surface this plugin is actually used in — hooks are Claude Code CLI only, and the Claude apps
  don't run them.

  > **Correction (1.4.0).** The claim above is false and this entry is left in place only so the
  > record is honest about it. Hooks **do** run in Cowork, and hook stdout **does** reach the
  > model's context — confirmed empirically in 1.3.0. The removal rested on a single documentation
  > snippet and two open issues reporting non-firing, none of which had been tested on this
  > surface. The hook was restored in 1.3.0. Anyone reading 1.2.0 to decide whether hooks are
  > viable should read 1.3.0 instead. Keeping it meant every doc carried a surface caveat and the headline feature was
  untestable for most users. `plugins/make-it-make-sense/hooks/` is gone.

### Changed
- **The standing rule is now *the* mechanism, not a fallback.** `references/standing-rule.md` is a
  paste-once block for **Settings → Instructions for Claude**, which loads every turn. Same
  unconditional delivery the hook was meant to provide, in the place it actually works.
- **`/syco-killer --standing`** prints the block; the arm/disarm modes are gone with the hook.
- **README leads with the Plugins UI.** CLI install moved to a collapsed section.

## [1.1.0]

### Added
- **`syco-killer`: the standing rule for surfaces that can't run hooks.** The v1.0.0 design leaned
  entirely on a `UserPromptSubmit` hook to make the gate always-on — but hooks are a Claude Code CLI
  mechanism, and the Claude apps don't run them, so the centerpiece was inert for anyone working in
  the chat or desktop UI. `references/standing-rule.md` now carries a paste-ready block for
  **Settings → Instructions for Claude**, which loads every turn in those surfaces, plus a
  surface-support table and a behavioral test procedure that doesn't rely on asking the model
  whether it's loaded (asking is itself the sycophancy vector).
- **`/syco-killer --standing`** prints that block.

### Changed
- **`syco-killer` must not report the gate as armed where the hook can't run.** Claiming a
  successful arm in a surface that ignores hooks is exactly the unverified-success failure the
  skill's own agentic section prohibits — committed by the skill itself.
- **README** documents which mechanism applies per surface.

## [1.0.0]

First stable release. Two skills instead of one, and the first bundled hook. Versions 0.6.0
through 0.8.0 were developed but never released; their changes are consolidated here.

### Changed
- **Renamed from `jonstermash-skills`.** The repo and marketplace are now `mims-public`; the
  plugin inside is **Make It Make Sense** (`make-it-make-sense`). Splitting the two names is the
  point — the repo is a container that can hold more over time, while the plugin keeps the name
  the project is actually known by.

  | | |
  |---|---|
  | Repo / marketplace | `mims-public` |
  | Plugin | `make-it-make-sense` — displayed as **Make It Make Sense** |
  | Skills | `/make-it-make-sense`, `/syco-killer` |

  **The skills are unchanged** — both keep their names and their behavior.

  Breaking for installs. GitHub redirects the old repo URLs, but the marketplace and plugin IDs
  changed, so existing installs must remove the old marketplace and re-add it:
  `/plugin marketplace add jonstermash/mims-public` then `/plugin install make-it-make-sense@mims-public`.
- **Added `displayName`** so the `/plugin` picker shows "Make It Make Sense" rather than the
  kebab-case identifier.
- **Plugin description and keywords** now name both bundled skills.

### Added
- **New skill: `syco-killer`.** Sycophancy treated as an accuracy failure, not a tone problem — it
  trades information for comfort, and it's self-erasing, since praise that's automatic carries no
  signal and takes the honest verdicts down with it. Runs **last**, as a gate on the drafted
  response rather than as framing on the way in; you can't filter a response you haven't written.
  Four gates, one per moment sycophancy enters: **the Open** (validation openers — delete the first
  sentence and see if anything is lost), **the Judgment** (the view in the first two sentences,
  unhedged; rank, don't array), **the Challenge** (sort pushback into new information → update,
  restated preference on their call → comply without pretending you were convinced, and assertion
  without evidence → hold and name the falsifier), and **the Close** (a question earns its place
  only if the two answers produce different work). Two tests decide any given line: the **razor**
  (delete it — if the reader loses nothing, it was padding) and the **mirror** (an assessment is
  information only if the opposite verdict was available). Plus a full agentic section — the claim
  ladder, done-means-done, weakened assertions, and the can't-verify protocol.
  Explicitly bounded against overcorrection: manufactured disagreement, do-nothing caveats, and
  hedging a solid answer are the same failure inverted; agreeing with something correct is accuracy;
  and the posture is never announced, since "to be blunt" is flattery pointed at yourself. Eases off
  — without switching off — where someone is distressed or courtesy is doing real social work.
  Tell-lists and worked rewrites in `references/tells.md` and `references/outcome-honesty.md`.
  Gate 2 and Gate 3 are grounded in the measurement literature rather than intuition: feedback
  bending to stated authorship and stated sentiment (the best-measured effect), mimicry of user
  mistakes, citation-flavored pushback as the highest-risk reversal trigger rather than the most
  convincing one, and the ~78% persistence of a reversal once you've folded. The same literature
  corrected an over-rotation in the draft — pressure-induced reversals run about 3:1 toward the
  *right* answer, so "restore the original if you can't name a new fact" was rewritten to accept an
  error you found on re-check as a legitimate mover.
- **First bundled hook: opt-in `UserPromptSubmit` injection.** A skill only loads when its
  description matches the moment, which is the wrong mechanism here — a sycophantic response doesn't
  feel sycophantic from the inside, so the skill would fire precisely when it isn't needed. The
  plugin now ships `hooks/hooks.json` and `hooks/syco-killer.sh`, injecting a ~35-line compressed
  rule ahead of every prompt in every session. Gated on `~/.claude/syco-killer.on` and silent until
  armed with `/syco-killer`, since installing a writing plugin shouldn't silently change how the
  assistant talks. `/syco-killer off` disarms; `/syco-killer --audit` reviews recent turns.

## [0.5.1]

### Added
- **`make-it-make-sense`: new line tell — the rhythmic `X, not Y` antithesis.** `line-edit.md` now
  flags antithesis reached for cadence rather than information ("that's a default, not a glitch"),
  and separates it from the *defensive* `X, not Y` already handled in `framing-tells.md` and from a
  genuine informative contrast that earns its place. Includes the strike-the-negation test and the
  same authorial-voice caution the fragment tic carries.

## [0.5.0]

### Changed
- **`make-it-make-sense`: restructured as an editor's procedure.** The skill now runs as *frame the
  reader → three passes (substance, structure, line), each closed by a gate → cold read*, replacing
  the flat list of rule sections. The reframing makes the checks actually fire: a gate you must clear
  to leave a pass runs, where an end-of-document checklist quietly gets skipped. Every prior principle
  is preserved — the exhaustive tell-lists, anti-patterns, and examples moved into per-pass reference
  files under `references/` (loaded on demand), while SKILL.md holds the runnable procedure and each
  gate fires from SKILL.md alone. Net: SKILL.md dropped from 217 to ~120 lines without losing a rule.

### Added
- **`make-it-make-sense`: frame-the-reader step.** A required first step — infer the reader from the
  draft's own signals, state the assumption in one line, and ask only on a genuine fork. Everything
  downstream (depth, cuts, what a heading can assume) is judged against it.
- **`make-it-make-sense`: new substance rules.** Cut defensive framing; impact over activity; make
  quantitative claims land (tie to money/decision, causation≠correlation, no overclaimed comparisons,
  "not a fluke" backed by the denominator or dropped); frame decisions consultatively (and check each
  decision is even the reader's to make).
- **`make-it-make-sense`: title and structure additions.** Reject throat-clearing/meta headings;
  don't force a claim (spin) onto reference content; don't editorialize a result in its headline;
  executive summaries earn their place only at a different altitude than the detail.
- **`make-it-make-sense`: layout rules.** Whitespace and reading direction as real structural tools.
- **`make-it-make-sense`: keep process/meta out of the deliverable.** Change-logs and edit rationale
  belong in the note to the requester, not the artifact.

## [0.4.0]

### Added
- **`make-it-make-sense`: `--codify` flag.** An opt-in, power-user path that reads a session's
  *voice* edits and drafts additions to the user's account-wide "Instructions for Claude." Separate
  from the editing pass — the pass de-slops everyone's output; `--codify` captures one person's
  voice. Includes a proactive one-per-session offer after voice-heavy sessions. Design rationale and
  known limitations: [`docs/design/codify.md`](docs/design/codify.md).

### Changed
- **`make-it-make-sense`: trimmed the frontmatter `description` under the 1,024-character limit.**
  It was 1,283 characters (over the platform cap and at risk of truncation, which would cut trigger
  keywords). Every trigger cue is preserved; only rationale prose was cut.

  > **Correction (1.4.0).** The 1,024 figure is wrong and was never sourced. The documented cap is
  > **1,536** for `description` + `when_to_use` combined, configurable via
  > `skillListingMaxDescChars`. The trim itself was still sound — 1,283 characters of rationale
  > prose was worth cutting — but the number was invented, and it went on to constrain later
  > releases for no reason. Don't carry it forward.

## [0.3.0] and earlier

See git history. Versions through 0.3.0 predate this changelog:
- **0.3.0 / 0.2.0** — expanded `make-it-make-sense` with accuracy, heading, and redundancy rules.
- **0.1.0** — initial `make-it-make-sense` skill; restructured the repo as an installable plugin
  marketplace.
