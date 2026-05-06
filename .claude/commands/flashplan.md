---
description: Plan a Linear ticket (or PRD) into a Haiku-executable spec at /Users/etan/documents/flash_adr_ed/<branch>.md
argument-hint: [DEV-XXXX | PRD text]
allowed-tools: Read, Grep, Glob, Bash(git *), Write, mcp__claude_ai_Linear__get_issue
---

You are producing a detailed implementation plan for a *fast but limited* model (Haiku) to execute. Your job is to remove every reason for Haiku to grep, search, or guess: the plan must be self-contained, with explicit `file:line` citations for every reference.

## Step 1 — Resolve input

`$ARGUMENTS` may contain:
- A Linear ticket ID like `DEV-4478` → fetch with `mcp__claude_ai_Linear__get_issue`.
- Free-form PRD text → use as-is.
- Empty → ask the user to provide a ticket ID or paste a PRD. Do not proceed without input.

## Step 2 — Resolve output path

1. Run `git branch --show-current` to get the branch name.
2. Lowercase it; if it has a prefix like `feature/dev-4478-foo`, extract the `dev-XXXX` portion.
3. Output file: `/Users/etan/documents/flash_adr_ed/<name>.md`.
4. Show the user the resolved path and confirm before writing.

## Step 3 — Ask clarifying questions liberally

Before planning, surface every ambiguity you can find. Ask as many questions as needed. Do **not** start planning until the user has answered or explicitly told you to proceed. Examples of things to probe:

- Missing acceptance criteria, edge cases, error states.
- Unstated assumptions about data shape, API contracts, auth, permissions.
- Which app(s) in the monorepo this affects.
- Backwards-compat requirements.
- UI states (empty / loading / error) not described.

## Step 4 — Explore the codebase

Use Read / Grep / Glob to ground every reference. For each existing symbol you mention later, capture `file:line`. Specifically look for:

- Existing components, hooks, utilities, API clients to reuse.
- Existing types, contracts, schemas to extend instead of duplicate.
- Existing tests to model new tests after.
- Existing patterns in the affected package (especially in `galatea` — see Step 5).

## Step 5 — Convention vs. best-practice flagging

When the planned approach follows an existing codebase convention that **conflicts with general best practice** (security, correctness, maintainability, accessibility, performance), flag it inline next to the affected task with a `> ⚠ Convention deviation:` callout. Explain:

- What the convention is.
- Why it deviates from best practice.
- Why we're following it anyway (consistency / scope / out-of-scope-to-fix).

Pay extra attention in `galatea` (the mobile app) — it accumulates these patterns more than other packages. Do not silently propagate; always call out.

## Step 6 — Write the plan file

Output the plan in this exact structure:

```markdown
# <Ticket ID or short title>

**Linear:** <link if available>
**Branch:** <git branch>
**Date:** <today's date>

## Task

<One-sentence restatement of what we're building.>

## Constraints & open questions

- <Anything still unresolved or risky.>

## Reusable assets

- `path/to/file.ts:42` — <what it is and why we reuse it>
- ...

## Stages

### Stage 1 — <name>

**Goal:** <one sentence>

#### Tasks

- [ ] **Update** `apps/foo/components/Bar.tsx:120`
  `submitForm(data: FormData): Promise<Result>`
  <intent in 1–2 sentences>
  References to read before implementing:
  - `apps/foo/api/client.ts:18` (HTTP wrapper)
  - `packages/types/forms.ts:5` (FormData shape)

  > ⚠ Convention deviation (galatea): inline error toast instead of `<ErrorBanner />`.
  > galatea uses ad-hoc `Toast.show()` everywhere; the rest of the repo uses `ErrorBanner`.
  > We follow galatea's convention here for consistency, but flag it for a future cleanup.

- [ ] **Create** `apps/foo/utils/parseDate.ts`
  `parseDate(input: string): Date | null`
  <intent>
  References:
  - `packages/utils/date.ts:30` (existing time-zone helper to wrap)

### Stage 2 — <name>

...
```

## Hard rules

- **Never write code** beyond function signatures in the plan. No implementation bodies.
- **Never modify files** other than the plan file you write at the resolved output path.
- **Every reference is `file:line`.** No vague "see the form component" — always cite.
- **Order stages by dependency**, then logical order within a stage. Haiku will execute top-to-bottom.
- **Each task is function-level**: one file + one signature + intent + cited references. Do not bundle multiple unrelated changes into one task.
- **If you are unsure**, ask. The cost of asking is low; the cost of a wrong plan that Haiku faithfully executes is high.
