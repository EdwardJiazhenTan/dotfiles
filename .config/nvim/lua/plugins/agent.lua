return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    init = function()
      vim.o.autoread = true
    end,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open("opencode --port", {
              win = {
                position = "right",
                width = math.floor(vim.o.columns * 0.35),
              },
            })
          end,
        },
        lsp = {
          enabled = true,
        },
        events = {
          permissions = {
            idle_delay_ms = 200,
            edits = {
              enabled = true,
            },
          },
        },
      }
      pcall(vim.api.nvim_del_augroup_by_name, "OpencodeEdits")
      require("util.opencode_inline_diff").setup()
    end,
    keys = {
      {
        "<leader>op",
        function()
          require("opencode").ask("")
        end,
        mode = "n",
        desc = "Ask opencode",
      },
      {
        "<leader>op",
        function()
          require("opencode").ask("@this")
        end,
        mode = "x",
        desc = "Ask opencode about selection",
      },
      {
        "<leader>oc",
        function()
          require("opencode").command("agent.cycle")
        end,
        mode = "n",
        desc = "Cycle opencode agent",
      },
      {
        "<leader>k",
        function()
          require("opencode").prompt("Explain @this")
        end,
        mode = { "n", "x" },
        desc = "Ask opencode to explain this",
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select opencode",
      },
      {
        "<leader>ot",
        function()
          require("snacks.terminal").toggle("opencode --port", {
            win = {
              position = "right",
              width = math.floor(vim.o.columns * 0.35),
            },
          })
        end,
        mode = { "n", "t" },
        desc = "Toggle opencode",
      },
      {
        "<leader>ou",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Scroll opencode up",
      },
      {
        "<leader>od",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Scroll opencode down",
      },
    },
  },
}
