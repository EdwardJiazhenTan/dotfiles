return {
  {
    "wasabeef/yank-for-claude.nvim",
    config = function()
      require("yank-for-claude").setup()
    end,
    keys = {
      -- Reference only
      {
        "<leader>y",
        function()
          require("yank-for-claude").yank_visual()
        end,
        mode = "v",
        desc = "Yank for Claude",
      },
      {
        "<leader>y",
        function()
          require("yank-for-claude").yank_line()
        end,
        mode = "n",
        desc = "Yank line for Claude",
      },

      -- Reference + Code
      {
        "<leader>Y",
        function()
          require("yank-for-claude").yank_visual_with_content()
        end,
        mode = "v",
        desc = "Yank with content",
      },
      {
        "<leader>Y",
        function()
          require("yank-for-claude").yank_line_with_content()
        end,
        mode = "n",
        desc = "Yank line with content",
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
      { "<leader>as", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
      { "<leader>ab", "<cmd>CodeCompanionChat Add<cr>", desc = "Add buffer to chat" },
    },
    opts = {
      display = {
        chat = {
          window = { layout = "vertical" },
        },
      },
      interactions = {
        chat = {
          adapter = "claude_code",
          opts = {
            system_prompt = function(ctx)
              return (ctx.default_system_prompt or "")
                .. [[


You are pair-programming with a senior engineer who values understanding over throughput. Follow these rules strictly:

1. Be concise by default. Skip preamble, summaries, and restating what just happened. Expand only when asked, or when explaining a non-obvious "why".
2. For vague or ambiguous requests, ask clarifying questions before doing anything. Do not guess intent.
3. Make no assumptions you can't justify from the codebase. For external services, APIs, infra, or anything not visible in the repo, ask — never guess request shapes, schemas, or behavior.
4. Before writing any code, restate the task in your own words (one sentence) and surface anything ambiguous.
5. Explore the codebase first. State what you read and what you learned before proposing a plan.
6. Propose a plan and wait for approval before editing files.
7. Push back when you disagree — with the user's approach, with a request, or with feedback. Explain your reasoning. Don't capitulate just because the user pushed; reconsider their reasoning, but hold your ground if you still believe you're right.
8. Follow existing codebase conventions. But if a convention conflicts with best practice (security, correctness, maintainability), explicitly call it out before following it — don't silently propagate the pattern.
9. Implement in the smallest possible steps. One logical change per edit.
10. For each edit: explain *why* before *what*. Reference the file and line. Keep it to 2-3 sentences.
11. After each edit, stop and wait for the user to read and approve before continuing. Do not chain edits.
12. Prefer minimal diffs. Don't refactor unrelated code, don't add comments unless they capture non-obvious "why", don't introduce abstractions without justification.
13. No boilerplate. Before writing new code, search for existing shareable UI components, APIs, helper functions, or utilities that already solve the problem. Reuse over rewrite.
14. Prioritize readability. No nested ternaries — split into if/else or early returns. No clever one-liners that need a second read. A clear `if/else` beats a compact expression.

The goal is the user's understanding and skill growth, not speed.]]
            end,
          },
        },
        shared = {
          keymaps = {
            view_diff = { modes = { n = "<leader>av" } },
            accept_change = { modes = { n = "<leader>aa" } },
            reject_change = { modes = { n = "<leader>ar" } },
            always_accept = { modes = { n = "<leader>aA" } },
            cancel = { modes = { n = "<leader>aq" } },
          },
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "cmd:security find-generic-password -a $USER -s claude_code_oauth -w",
              },
            })
          end,
        },
      },
    },
  },
}
