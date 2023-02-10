return {

  -- toggle background transparency
  {
    "xiyaowong/nvim-transparent",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- persistent colorscheme picker
  {
    "jamesiain/colorscheme-persist.nvim",
    event = { "BufReadPre", "BufNewFile" },
    priority = 1000,
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      "xiyaowong/nvim-transparent",
    },
    keys = {
      {
        "<leader>cs",
        function()
          require("colorscheme-persist").picker()
        end,
        mode = { "n" },
        desc = "Select Colorscheme",
      },
    },
    opts = function()
      local os_sep = require("plenary.path").path.sep
      return {
        file_path = vim.fn.stdpath "state" .. os_sep .. "colorscheme-persist.lua",
        fallback = "habamax", -- least offensive built-in colorscheme
        disable = { -- do not include built-in colorschemes in picker
          "blue",
          "darkblue",
          "default",
          "delek",
          "desert",
          "elflord",
          "evening",
          "industry",
          "koehler",
          "lunaperche",
          "morning",
          "murphy",
          "pablo",
          "peachpuff",
          "quiet",
          "ron",
          "shine",
          "slate",
          "torte",
          "zellner",
        },
        enable_preview = true,
      }
    end,
  },

  -- colorschemes
  { "shaunsingh/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        style = "moon",
        -- transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
        sidebars = {
          "qf",
          "vista_kind",
          "terminal",
          "spectre_panel",
          "startuptime",
          "Outline",
        },
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.orange, bold = true }
          hl.LineNr = { fg = c.orange, bold = true }
          hl.LineNrAbove = { fg = c.fg_gutter }
          hl.LineNrBelow = { fg = c.fg_gutter }
          local prompt = "#2d3149"
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      }
    end,
  },
}
