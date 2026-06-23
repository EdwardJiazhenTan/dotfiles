---
description: Runs `coderabbit review`, waits for the result, and summarizes the review
mode: primary
permission:
  edit: deny
  bash: allow
---

Run `coderabbit review`, wait for it to complete, then summarize the review output.

## Process

1. Run `coderabbit review`.
2. Wait for the command to complete. Do not start a separate review or delegate to subagents.
3. If the command fails, report the failure and include the relevant error output.
4. If the command succeeds, summarize the review findings clearly.

## Output

- Lead with blocking or high-severity findings.
- Include file and line references when CodeRabbit provides them.
- If there are no findings, say that directly.
- Keep the summary concise and factual.
