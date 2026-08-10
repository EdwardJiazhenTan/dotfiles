Scaffold an ADR (Architecture Decision Record) for the current branch.

1. Run `git branch --show-current` to get the branch name and extract the ticket ID (e.g. `DEV-4415`).
2. Run `git config user.name` to get the author name.
3. Create `docs/adr/<ticket>.md` using this format:

```md
---
ticket: <ticket>
author: <author>
---

<leave blank for the user to fill in>
```

4. Tell the user the file was created and open it with the Read tool so they can see it.

If the branch name contains no ticket ID, ask the user to provide one.
