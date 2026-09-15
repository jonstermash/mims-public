---
name: strategy-planner
description: >-
  Build a strategy for any brand, product, or idea from the ground up — a top-down cascade of five
  stages (Goal → Objectives → Audiences → Messaging → Tactics), each grounded in evidence and
  locked before the next begins, with a defined way to reopen stages when evidence changes. Use
  this whenever someone wants to turn scattered research, notes, or context into a strategy that
  guides decisions; plan go-to-market, marketing, launch, or positioning for something new; define
  audiences or messaging; or build assets (decks, one-pagers, landing pages, pitches) that should
  trace back to a strategy — even if they never say the word "strategy."
---

# Mims Strategy Planner

A top-down planning model that turns scattered context and research into a
strategy that **guides decisions**. Five stages, done **in order**. Each stage
flows from the one above it — you can't pick audiences before you know the goal,
or write messages before you know the audience.

The output is a **living strategy document** plus a short **STATUS** doc. Start
every run by copying the templates in `assets/` (see "Artifacts" below).

## Files in this skill — read when you reach them

| File | Read it when |
|---|---|
| `assets/strategy-doc-template.md` | Starting a run — this is the doc you fill in |
| `assets/status-template.md` | Starting a run, and at the end of every session |
| `references/confidence-tags.md` | Recording any claim or evidence |
| `references/messaging-by-audience-type.md` | Stage 4, before drafting for channel or influence audiences |
| `references/expansion-ladder.md` | Turning a message into longer copy or a spoken/timed asset |
| `references/asset-qa.md` | Before calling any Stage 5 asset done |
| `references/persona-review.md` | Before locking any Stage 5 asset |

---

## The five stages

Do them in order. Don't skip ahead. Lock each before starting the next.
A lock records **who decided and when** in the strategy doc.

### 1. Goal / Big Idea
**What:** One forward-looking statement of what the thing *becomes* — the north
star. Aspirational, but concrete enough to point at.
**Good looks like:** present tense, stated as who you're becoming ("X is the …");
bold enough to be a north star, anchored enough to stay concrete; the whole team
could repeat it.
**Facilitate:** offer 2–3 drafts at different levels of ambition (grounded →
category-defining) and let the owner react. The altitude is the owner's call.
**Pitfalls:** a goal that just describes today's product (too small); a goal so
abstract it could belong to anyone (too vague). Keep the near-term proof and the
long-term vision distinct — the goal points at the vision.

### 2. Objectives
**What:** The measurable, time-bound outcomes that show progress toward the Goal.
**Good looks like:** each is a number + a date; each visibly ladders to the Goal;
together they cover both near-term proof (the wedge) and long-term progress (the moat).
**Facilitate:** anchor to real milestones the owner already has. Push back on
vanity metrics. Name the **validation instrument** for each (what will prove it)
and the **unlock trigger** — the result that would send you back up the cascade
(see "Reopening a locked stage").
**Pitfalls:** objectives that are all near-term revenue and none point at the
long-term goal; unmeasurable "increase awareness" objectives; no deadline.

### 3. Core Audiences
**What:** The groups you must reach to hit the Objectives — defined by **shared
self-interest + behavioral pattern**, NOT by product. The same person may be a
prospect for more than one product; a partner/reseller is its own audience even
though they never "buy."
**Good looks like:** each audience has a distinct self-interest and a distinct
behavior; each maps to the objective(s) it moves; explicit NON-audiences are named.
**Facilitate:** ground every attribute in evidence and tag it
(`references/confidence-tags.md`). Separate the economic buyer, the
champion/user, the gatekeeper, the channel, and the long-game audience.
For each audience, record whether they **know what they're missing**.

**The missing-information trap.** Some audiences don't know the problem you solve
is a problem — they've never had the capability, so they don't feel its absence.
They won't translate a feature list into a pain they recognize. For these
audiences, messaging must *reveal the felt pain first* ("you're finding out about
X two weeks late") before any outcome or feature lands. Flag trap audiences here
so Stage 4 and the persona review can check for it.

**Pitfalls:** confusing a product line with an audience; listing personas nobody
will act on; asserting buyer behavior you haven't verified.

### 4. Primary & Secondary Messaging
Built **per audience**.
- **Primary = WHAT the audience gets** — the outcome, in their terms. Sell the
  outcome; the "how" (the technology) sits underneath, never on top.
- **Secondary = WHY it's true** — the proof, the mechanism, or the specific
  product features that deliver the primary.
- An audience can have **several primaries** (e.g. near-term outcomes + a vision
  outcome). Group them if it helps.

**Rules — every line, every time:**
- **Secondary messages: 200 characters max each** (count them, spaces included).
  If support needs more, split it into two secondaries or move the detail into
  long-form copy via the expansion ladder.
- **Stands alone.** It must make full sense to a stranger with zero context. No
  "getting started" (with *what*?), no phrase that only works if you were in the room.
- **Plain, scannable, not salesy.** No jargon without a gloss; no hype.
- **Outcome first.** The primary says what they *get*, not what the product *is*
  or mechanically *does*.
- **Follow the build-status rule** (below) — flag roadmap items in the strategy
  doc, never in published copy.
- **Unproven ideas are conversation probes, not primaries.** If you can't stand
  behind a claim, label it a probe to raise in conversation.
- **Trap audiences lead with the pain** (see Stage 3).

**Audience-type nuances:** buyers get their own outcome as the primary. Channel
and influence audiences work differently — read
`references/messaging-by-audience-type.md` before drafting for them.

**Good looks like:** the strongest proof (customer-proven facts) does the
heaviest lifting; every primary has support; vision primaries are supported
*and* flagged internally.
**Facilitate:** calibrate on ONE audience first, get it right, then apply the
pattern to the rest. Mine earlier stages for raw material. Lead with what's proven.
**Pitfalls:** taglines instead of messages; the same message to every audience;
a clever line that assumes context; a vision claim with nothing under it.

### 5. Strategies & Tactics
**What:** The actual assets and actions you put in front of audiences to complete
the Objectives (campaigns, collateral, demos, content, channels, events).
Built almost entirely *from* the Stage 4 message set (see handoff below).

**Work through it in this order:**

1. **Draft the tactic map.** One row per tactic, in the strategy doc:

   | Tactic / asset | Audience | Objective | Primary message(s) | Depends on | Effort | Success signal | Status |
   |---|---|---|---|---|---|---|---|

   Every tactic fills the first four columns. If it can't, it's off-strategy or
   the message set is missing something — fix the strategy, don't free-write the asset.

2. **Run the coverage check.** Read the map both ways:
   - Every audience and every objective has at least one tactic aimed at it.
     Flag any gap explicitly.
   - Every tactic traces to an audience and objective. Cut or fix orphans.

3. **Sequence by dependency.** Fill "Depends on" — which assets must exist before
   this one can ship (a one-pager promising "materials to send" depends on those
   materials). Order the build list so nothing ships promising something that
   doesn't exist yet, and so the nearest objective deadline sets the pace.

4. **Size effort, not budget.** Mark each tactic's effort (S / M / L) and likely
   impact on its objective. Owner time is the real constraint — favor
   high-impact, low-effort tactics first, and don't start more in parallel than
   the team can finish. (No budget needed at this stage; add it only if the owner
   brings one.)

5. **Name a success signal per tactic.** A leading indicator that shows this
   specific tactic is moving its objective — e.g. "demo → 3 follow-up calls
   booked in 30 days." It should roll up to the objective's validation instrument.

6. **Set retire-or-revise criteria.** For each tactic, decide in advance what
   "not working" looks like and when you'll check. When a signal misses, diagnose:
   - **The asset is weak** → revise the asset (Stage 5).
   - **The message doesn't land** across assets → reopen Stage 4.
   - **The audience doesn't behave as modeled** → reopen Stage 3.
   Use "Reopening a locked stage" for the last two.

**Before any asset is done:** run `references/asset-qa.md`, then
`references/persona-review.md`. For longer copy or spoken assets, use
`references/expansion-ladder.md`.

**Pitfalls:** a tactic list disconnected from the strategy above it ("let's do a
podcast" with no line back to an objective); everything started at once; no way
to tell if a tactic is working.

---

## Message → asset handoff (Stage 4 → Stage 5)

Hand off a clean **message set per audience** so every asset traces to strategy.
For each audience, Stage 5 inherits:
- the **objective(s)** it moves and the **action** it should drive,
- the **primary messages** → headlines, hooks, subject lines, openers,
- the **secondary messages** → body copy, bullets, case-study call-outs, FAQ answers,
- the **roadmap flags** (internal — so an asset never sells an unbuilt feature)
  and the **probes** (for live conversation, not published copy),
- whether the audience is a **missing-information trap**.

**Rule:** every asset names the audience + objective + primary message(s) it serves.

---

## The build-status rule (single source — other sections point here)

**Internal honesty, external confidence.**
- **In the strategy doc:** flag what's built vs. roadmap so the team knows.
- **In durable published assets** (site, deck, one-pager, long-form copy): present
  the vision as a confident, present-tense whole. **Never label features
  "roadmap / coming soon" or expose build status** — it reads amateur and hands
  competitors your timeline.
- **In live founder narration** (a talk, a call, a pitch told as your own story):
  naming the stage ("Generate ships today, Visualize is in beta") is honest and
  often builds credibility.
- **The invariant, in every medium:** never **sell, charge for, or make a customer
  operationally depend on** something that isn't there. Carrying the vision as
  who-you-are is fine; promising a specific unbuilt deliverable is not.

---

## Reopening a locked stage

Locks keep work moving, but evidence can overturn them. The cascade runs downhill;
this is the one way back up.

**Triggers:** a validation instrument returns a result that contradicts a locked
stage; a success-signal miss is diagnosed as a message or audience problem; new
verified evidence contradicts a locked claim; the owner changes the goal.

**Protocol:**
1. **Name the trigger and the evidence**, tagged (`references/confidence-tags.md`).
   A single data point is a reason to investigate, not to unlock.
2. **Find the highest stage the evidence actually breaks.** Unlock that stage only.
3. **The owner decides** whether to unlock. Recommend; don't unlock on your own.
4. **Mark everything below it "under review"** — don't delete it. Keep downstream
   work that still holds.
5. **Re-lock top-down,** then re-check each lower stage against the change and
   re-lock or revise it. Re-run the coverage check in Stage 5.
6. **Log it** in the strategy doc's change log: what changed, why, who decided, when.
   Assets affected by the change get flagged in their headers.

---

## Operating principles (these make or break it)

1. **Accuracy guides decisions; hedging paralyzes them.** State high-confidence
   claims plainly. A high-confidence hypothesis is a fine basis for a decision.
2. **Ground every claim in evidence; separate facts from hypotheses.** Tag
   confidence (`references/confidence-tags.md`). Don't tag-and-keep noise — a
   claim you don't actually hold gets removed, not labeled.
3. **Verify before you dismiss.** Check both the source material *and* external
   research before calling something unsupported.
4. **Encode the concept, not the example.** Don't turn a throwaway illustration
   into a tracked claim.
5. **Plain language; write to scan.** No jargon or acronyms without a gloss.
6. **Work in order, collaboratively.** Propose options at each fork, recommend one,
   let the owner react, then LOCK. Ask only what's genuinely the owner's call.
7. **Record as you go.** Living doc, status per stage, who decided and when,
   evidence appendix, change log.
8. **Distinguish the wedge from the moat.** The Goal points at the moat; early
   Objectives prove the wedge.
9. **Carry tensions forward, don't paper over them.** Flag contradictions for the
   stage that will resolve them.
10. **Tie every objective to a validation instrument and an unlock trigger.**
11. **Every line stands on its own.** Write for a stranger reading it cold.
12. **Follow the build-status rule** (above).

## Facilitation stance
- One stage at a time. Don't run ahead to tactics while the goal is still open.
- At decision forks, present concrete drafts to react to — not open-ended
  questions. Recommend; don't just survey.
- The owner sets vision, ambition, and anything that's genuinely their call.
  You do the organizing, grounding, research, and drafting.

## Artifacts a run produces
- **Strategy doc** from `assets/strategy-doc-template.md`: one section per stage,
  LOCKED status with owner + date, tactic map, evidence appendix, "to validate"
  list, change log.
- **STATUS doc** from `assets/status-template.md`: the read-me-first for resuming.
- **Self-describing assets:** each asset file opens with a header stating what it
  is, its audience / objective / messages, and what's done vs. outstanding.

## Resuming across context resets
A run spans many sessions — assume context will be cleared mid-way.
- Never rely on chat history or an ephemeral memory store for resume-critical state.
  Update the STATUS doc at the end of every session.
- To resume a copy task cold: open the audience's Stage 3 profile + Stage 4
  messages → the asset's header (audience / objective / action) → expand with
  `references/expansion-ladder.md`.
- Leave a one-line pointer to the STATUS doc in whatever persistent index the
  project uses.
