#!/usr/bin/env bash
# check-repo.sh — the release invariants, enforced rather than remembered.
#
# Usage:
#   scripts/check-repo.sh        run every check; exit 1 if any ERROR fired
#
# Run by .github/workflows/checks.yml on push and pull_request, and runnable by
# hand before committing. One implementation, one source of truth — the workflow
# calls this script rather than reimplementing the checks in YAML.
#
# ---------------------------------------------------------------------------
# WHY THESE FIVE
# ---------------------------------------------------------------------------
# Each one maps to a way an install has actually broken, or can break silently:
#
#   1. JSON PARSE     a malformed manifest takes the marketplace down entirely.
#   2. VERSION PARITY the failure this script was written for. 79e2728 bumped
#                     plugin.json and left marketplace.json on 1.4.0; the /plugin
#                     GUI reads the catalog, so a shipped release reached nobody.
#                     stamp-build.sh --check cannot see this: marketplace.json
#                     lives OUTSIDE the plugin dir and is not in the hashed set.
#   3. STAMP DRIFT    delegated to stamp-build.sh --check. Catches a shipped file
#                     edited without re-stamping, which makes the build line the
#                     hook prints every prompt describe a build nobody is running.
#   4. SKILL NAME     no explicit `name:` and the invocation name falls back to
#                     the install directory — a version string for marketplace
#                     installs, so it changes on every update and the skill
#                     silently becomes uninvocable. Nothing errors; it just stops
#                     working.
#   5. VERSION BUMP   check 2 proves the four sources AGREE. Four sources can
#                     agree on a number that never moved. The version is what
#                     tells an install there is something to fetch, so shipping
#                     edited plugin files at an unchanged version delivers them
#                     to nobody — the 79e2728 outcome by a different route, and
#                     the one that leaves no disagreement behind to find later.
#                     Re-stamping keeps BUILD consistent with the edit, so checks
#                     2 and 3 both pass while the release goes nowhere.
#
# ---------------------------------------------------------------------------
# ERROR vs WARN
# ---------------------------------------------------------------------------
# Only invariants that BREAK something are errors. The description length check
# warns instead: 1,536 is the documented default for the combined description and
# when_to_use text, it's configurable via skillListingMaxDescChars, and overflow
# is silent truncation in the skill listing rather than a failure. Failing a build
# on a configurable default would re-enact the v0.4.0 mistake of enforcing a cap
# the tooling never imposed — this repo already spent a release retiring a number
# it had enforced wrongly for four versions. Report it, don't gate on it.
#
# Check 5 warns in one case and errors in the other. A version that went
# backwards or stood still against a real edit is an error: that is the failure.
# Not being able to FIND a baseline to compare against — no git, a shallow clone,
# a branch with no ancestor on the default branch — is a warning. The check has
# nothing to say there, and a check that fails when it can't see is a check
# people start passing with --no-verify.
# ---------------------------------------------------------------------------

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT" || exit 1

MARKETPLACE=".claude-plugin/marketplace.json"
PLUGIN_JSON="plugins/make-it-make-sense/.claude-plugin/plugin.json"
BUILD_FILE="plugins/make-it-make-sense/BUILD"
SKILLS_DIR="plugins/make-it-make-sense/skills"
DESC_LIMIT=1536

FAILED=0
err()  { echo "  ERROR: $*"; FAILED=1; }
warn() { echo "  WARN:  $*"; }
ok()   { echo "  ok:    $*"; }

# ------------------------------------------------------------ 1. JSON parses
echo "[1/5] manifests parse as JSON"
for f in "$MARKETPLACE" "$PLUGIN_JSON"; do
  if [ ! -f "$f" ]; then
    err "$f is missing"
  elif python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" 2>/dev/null; then
    ok "$f"
  else
    err "$f is not valid JSON"
    python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" 2>&1 | sed 's/^/         /'
  fi
done

# -------------------------------------------------------- 2. version parity
# Four places record the version and all four must agree. Read each from its own
# file rather than deriving one from another, or the check can't see a mismatch.
echo "[2/5] version parity across all four sources"
MKT_V="$(python3 -c "
import json
try: print(json.load(open('$MARKETPLACE'))['plugins'][0]['version'])
except Exception: print('')
" 2>/dev/null)"
PLG_V="$(python3 -c "
import json
try: print(json.load(open('$PLUGIN_JSON'))['version'])
except Exception: print('')
" 2>/dev/null)"
BLD_V="$(awk '/^version:/{print $2; exit}' "$BUILD_FILE" 2>/dev/null)"
# Top-most '## [x.y.z]' heading in the changelog.
CHG_V="$(awk 'match($0, /^## \[([0-9]+\.[0-9]+\.[0-9]+)\]/) {
  s = substr($0, RSTART, RLENGTH); gsub(/^## \[|\]$/, "", s); print s; exit
}' CHANGELOG.md 2>/dev/null)"

printf '         %-34s %s\n' "$MARKETPLACE"  "${MKT_V:-<unreadable>}"
printf '         %-34s %s\n' "$PLUGIN_JSON" "${PLG_V:-<unreadable>}"
printf '         %-34s %s\n' "$BUILD_FILE"  "${BLD_V:-<unreadable>}"
printf '         %-34s %s\n' "CHANGELOG.md (latest entry)" "${CHG_V:-<unreadable>}"

if [ -z "$MKT_V" ] || [ -z "$PLG_V" ] || [ -z "$BLD_V" ] || [ -z "$CHG_V" ]; then
  err "could not read a version from every source (see <unreadable> above)"
elif [ "$MKT_V" = "$PLG_V" ] && [ "$PLG_V" = "$BLD_V" ] && [ "$BLD_V" = "$CHG_V" ]; then
  ok "all four agree on $MKT_V"
else
  err "versions disagree — bump every source together, then re-stamp"
fi

# ---------------------------------------------------------- 3. build stamp
echo "[3/5] build stamp matches the plugin tree"
if [ ! -x scripts/stamp-build.sh ]; then
  err "scripts/stamp-build.sh is missing or not executable"
else
  if STAMP_OUT="$(scripts/stamp-build.sh --check 2>&1)"; then
    printf '%s\n' "$STAMP_OUT" | sed 's/^/         /'
    ok "stamp verified"
  else
    printf '%s\n' "$STAMP_OUT" | sed 's/^/         /'
    err "stamp drift — run scripts/stamp-build.sh and commit the result"
  fi
fi

# ------------------------------------------------------ 4. SKILL.md frontmatter
echo "[4/5] every SKILL.md declares an explicit name"
SKILL_REPORT="$(python3 - "$SKILLS_DIR" "$DESC_LIMIT" <<'PY'
import os, sys

skills_dir, limit = sys.argv[1], int(sys.argv[2])

def frontmatter(path):
    """Parse the leading --- block. Handles folded scalars (>- , > , |) since
    both skills use them; a folded value joins on spaces, which is what the
    listing counts."""
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().split("\n")
    if not lines or lines[0].strip() != "---":
        return None
    try:
        end = lines.index("---", 1)
    except ValueError:
        return None
    fields, key, buf = {}, None, []
    for raw in lines[1:end]:
        if raw[:1] not in (" ", "\t") and ":" in raw:
            if key:
                fields[key] = " ".join(buf).strip()
            k, _, v = raw.partition(":")
            key, v = k.strip(), v.strip()
            buf = [] if v in (">-", ">", "|", "|-", "") else [v]
        elif key:
            buf.append(raw.strip())
    if key:
        fields[key] = " ".join(buf).strip()
    return fields

if not os.path.isdir(skills_dir):
    print("ERR|no skills directory at %s" % skills_dir)
    sys.exit(0)

found = False
for name in sorted(os.listdir(skills_dir)):
    path = os.path.join(skills_dir, name, "SKILL.md")
    if not os.path.isfile(path):
        continue
    found = True
    fm = frontmatter(path)
    if fm is None:
        print("ERR|%s has no YAML frontmatter block" % path)
        continue
    declared = fm.get("name", "").strip()
    if not declared:
        print("ERR|%s has no explicit `name:` — the invocation name would fall "
              "back to the install directory" % path)
    elif declared != name:
        print("ERR|%s declares name '%s' but lives in directory '%s'"
              % (path, declared, name))
    else:
        print("OK|%s -> /%s" % (path, declared))
    # Advisory only. See the ERROR vs WARN note at the top of check-repo.sh.
    n = len(fm.get("description", "")) + len(fm.get("when_to_use", ""))
    if n > limit:
        print("WARN|%s: description + when_to_use is %d chars, over the %d-char "
              "listing default (silently truncated, not an error)"
              % (path, n, limit))

if not found:
    print("ERR|no SKILL.md files found under %s" % skills_dir)
PY
)"

while IFS='|' read -r level msg; do
  [ -z "$level" ] && continue
  case "$level" in
    OK)   ok "$msg" ;;
    WARN) warn "$msg" ;;
    *)    err "$msg" ;;
  esac
done <<< "$SKILL_REPORT"

# ------------------------------------------------------- 5. version moved
# Check 2 proves the four sources agree. This one proves the number they agree on
# is not the number that shipped last time, whenever a file an install receives
# has changed.
#
# THE SHIPPED SET is every file under the plugin directory, plus marketplace.json
# because the /plugin GUI reads the catalog. BUILD is deliberately excluded: a
# re-stamp with the same content_hash changes only its timestamp line, and
# demanding a release for that would make the bump meaningless. Anything BUILD
# records a real change to shows up as the changed file itself.
#
# THE BASELINE is the released state to compare against, in the first order that
# resolves: an explicit BASELINE_REF, the PR's base branch, the previous commit
# when HEAD is the default branch itself, or the merge-base with the default
# branch. Compared against the WORKING TREE, not HEAD, so it fires before you
# commit rather than after you push — including on files not yet `git add`ed,
# which is what a brand-new skill folder looks like.
echo "[5/5] version moved since the last released state"
BASELINE=""
BASELINE_HOW=""
SHIPPED_PATHS=("plugins/make-it-make-sense" ":(exclude)$BUILD_FILE" "$MARKETPLACE")
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  warn "not a git checkout — nothing to compare against, skipping"
elif [ -n "${BASELINE_REF:-}" ]; then
  BASELINE="$(git rev-parse --verify "${BASELINE_REF}^{commit}" 2>/dev/null)"
  BASELINE_HOW="BASELINE_REF=${BASELINE_REF}"
  [ -z "$BASELINE" ] && warn "BASELINE_REF='${BASELINE_REF}' does not resolve to a commit, skipping"
else
  DEFAULT_REF=""
  for candidate in "origin/${GITHUB_BASE_REF:-}" origin/main origin/master main master; do
    case "$candidate" in origin/|"") continue ;; esac
    if git rev-parse --verify "$candidate^{commit}" >/dev/null 2>&1; then
      DEFAULT_REF="$candidate"
      break
    fi
  done
  if [ -z "$DEFAULT_REF" ]; then
    warn "no default branch ref found (shallow clone?) — skipping; set BASELINE_REF to compare"
  elif [ "$(git rev-parse HEAD 2>/dev/null)" = "$(git rev-parse "$DEFAULT_REF" 2>/dev/null)" ]; then
    # Sitting on the default branch, so HEAD is what shipped — unless the working
    # tree has moved past it, in which case HEAD is the released state and the
    # edit in front of us is the thing that needs a version. Committed or not,
    # the baseline is the last state an install could have fetched.
    if [ -n "$(git diff --name-only HEAD -- "${SHIPPED_PATHS[@]}" 2>/dev/null)$(git ls-files --others --exclude-standard -- "${SHIPPED_PATHS[@]}" 2>/dev/null)" ]; then
      BASELINE="$(git rev-parse --verify 'HEAD^{commit}' 2>/dev/null)"
      BASELINE_HOW="HEAD (uncommitted shipped edit on $DEFAULT_REF)"
    else
      BASELINE="$(git rev-parse --verify 'HEAD~1^{commit}' 2>/dev/null)"
      BASELINE_HOW="HEAD~1 (HEAD is $DEFAULT_REF)"
      [ -z "$BASELINE" ] && warn "HEAD has no parent — nothing to compare against, skipping"
    fi
  else
    BASELINE="$(git merge-base HEAD "$DEFAULT_REF" 2>/dev/null)"
    BASELINE_HOW="merge-base with $DEFAULT_REF"
    [ -z "$BASELINE" ] && warn "no common ancestor with $DEFAULT_REF — skipping"
  fi
fi

if [ -n "$BASELINE" ]; then
  CHANGED="$(git diff --name-only "$BASELINE" -- "${SHIPPED_PATHS[@]}" 2>/dev/null)"
  UNTRACKED="$(git ls-files --others --exclude-standard -- "${SHIPPED_PATHS[@]}" 2>/dev/null)"
  CHANGED="$(printf '%s\n%s\n' "$CHANGED" "$UNTRACKED" | sed '/^$/d' | sort -u)"
  BASE_V="$(git show "$BASELINE:$MARKETPLACE" 2>/dev/null | python3 -c "
import json,sys
try: print(json.load(sys.stdin)['plugins'][0]['version'])
except Exception: print('')
" 2>/dev/null)"

  printf '         %-34s %s\n' "baseline" "$(git rev-parse --short "$BASELINE") — $BASELINE_HOW"
  printf '         %-34s %s\n' "version there / here" "${BASE_V:-<unreadable>} -> ${MKT_V:-<unreadable>}"
  printf '         %-34s %s\n' "shipped files changed" "$(printf '%s' "$CHANGED" | grep -c . || true)"

  if [ -z "$CHANGED" ]; then
    ok "no shipped file changed — no bump needed"
  elif [ -z "$BASE_V" ]; then
    warn "no readable version at the baseline (pre-catalog history?) — skipping"
  elif [ -z "$MKT_V" ]; then
    err "shipped files changed but the current version is unreadable (see check 2)"
  else
    printf '%s\n' "$CHANGED" | sed 's/^/           /'
    if python3 -c "
import sys
def parse(v):
    return tuple(int(p) if p.isdigit() else -1 for p in v.strip().split('.'))
sys.exit(0 if parse(sys.argv[1]) > parse(sys.argv[2]) else 1)
" "$MKT_V" "$BASE_V"; then
      ok "$BASE_V -> $MKT_V for $(printf '%s' "$CHANGED" | grep -c . || true) changed shipped file(s)"
    else
      err "shipped files changed but the version did not increase ($BASE_V -> $MKT_V) — installs"
      echo "         only fetch an update when the catalog version moves, so this ships to nobody."
      echo "         Bump all four sources and re-stamp: scripts/stamp-build.sh"
    fi
  fi
fi

echo
if [ "$FAILED" -eq 0 ]; then
  echo "PASS — release invariants hold."
else
  echo "FAIL — fix the ERROR lines above before committing."
fi
exit "$FAILED"
