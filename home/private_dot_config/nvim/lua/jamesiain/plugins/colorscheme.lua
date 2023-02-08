
return {
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
  },
  {
    "jamesiain/colorscheme-persist.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-telescope/telescope-dap.nvim", },
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
  { "shaunsingh/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "folke/tokyonight.nvim", lazy = false },
}
