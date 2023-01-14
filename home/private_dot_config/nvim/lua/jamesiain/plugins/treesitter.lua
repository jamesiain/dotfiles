require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "markdown",
    "markdown_inline",
    "vim",
    "help",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<c-backspace",
    },
  },
  rainbow = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- you can use the capture groups defined in textobjects.scm
        ["aa"] = { query = "@parameter.outer", desc = "Select the outer part of a parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "Select the inner part of a parameter" },
        ["af"] = { query = "@function.outer", desc = "Select the outer part of a function" },
        ["if"] = { query = "@function.inner", desc = "Select the inner part of a function" },
        ["ac"] = { query = "@class.outer", desc = "Select the outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select the inner part of a class" },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps into the jumplist
      goto_next_start = {
        ["]m"] = { query = "@function.outer", desc = "Jump to start of next function" },
        ["]]"] = { query = "@class.outer", desc = "Jump to start of next class" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "Jump to end of next function" },
        ["]["] = { query = "@class.outer", desc = "Jump to end of next class" },
      },
      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = "Jump to start of previous function" },
        ["[["] = { query = "@class.outer", desc = "Jump to start of previous class" },
      },
      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = "Jump to end of previous function" },
        ["[]"] = { query = "@class.outer", desc = "Jump to end of previous class" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
      },
      swap_previous = {
        ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
      },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["<leader>df"] = { query = "@function.outer", desc = "Peek at function definition" },
        ["<leader>dF"] = { query = "@class.outer", desc = "Peek at class definition" },
      },
    },
  },
}

local opt = vim.opt

opt.foldlevel = 99 -- open all folds by default
opt.foldcolumn = "auto:9" -- show fold indicator in left gutter
opt.foldmethod = "expr" -- use custom folding logic
opt.foldexpr = "nvim_treesitter#foldexpr()"
