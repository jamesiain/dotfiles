local api = vim.api

local sync_packer = api.nvim_create_augroup("SyncPacker", { clear = true })

api.nvim_create_autocmd("BufWritePost", {
  group = sync_packer,
  pattern = "*/plugins/*.lua",
  command = "source <afile> | PackerSync",
})

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    local function plugin_config(name)
      return string.format('require("jamesiain.plugins.%s")', name)
    end

    local function plugin_defaults(name)
      return string.format('require("%s").setup()', name)
    end

    -- call out plugins below this line
    use "lewis6991/impatient.nvim"

    use { -- language server protocol (LSP)
      "neovim/nvim-lspconfig",
      requires = {
        -- automatic installation of servers to stdpath
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- ui improvements
        "onsails/lspkind-nvim",
        "SmiteshP/nvim-navic",
      },
      config = plugin_config "lspconfig",
    }

    use { -- autocompletion
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-calc",
        "lukas-reineke/cmp-rg",
        "rcarriga/cmp-dap",
        -- snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      config = plugin_config "cmp",
    }

    use { -- highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      run = function()
        pcall(require("nvim-treesitter.install").update { with_sync = true })
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor",
        "mrjones2014/nvim-ts-rainbow",
      },
      config = plugin_config "treesitter",
    }

    use { -- debug adapter protocol (DAP)
      "mfussenegger/nvim-dap",
      requires = {
        "ldelossa/nvim-dap-projects", -- per-project DAP settings
        "rcarriga/nvim-dap-ui", -- enhanced UI for DAP
        "theHamsta/nvim-dap-virtual-text", -- live evaluation of locals
        -- language-specific adapters
        "jbyuki/one-small-step-for-vimkind", -- Lua (inside NeoVim)
      },
      config = plugin_config "dap",
    }

    use { -- toggle comments ON/OFF on visual regions/lines
      "numToStr/Comment.nvim",
      config = plugin_defaults "Comment",
    }

    use { -- automatically insert the matching bracket (or other character)
      "windwp/nvim-autopairs",
      config = plugin_defaults "nvim-autopairs",
    }

    -- editor manipulations
    use "wsdjeg/vim-fetch" -- open "filename:248,13" at line 248 and column 13
    use "kshenoy/vim-signature" -- place, toggle, and display marks
    use "godlygeek/tabular" -- line up text easily
    use "tpope/vim-sleuth" -- detect tabstop and shiftwidth automatically

    use { -- navigating and writing to an Obsidian vault of markdown notes
      "epwalsh/obsidian.nvim",
      tag = "v1.*",
      config = plugin_config "obsidian",
    }

    use { -- 1Password for NeoVim!
      "mrjones2014/op.nvim",
      tag = "v1.*",
      run = "make install",
      config = plugin_defaults "op",
    }

    use { -- the premier plugin for git
      "tpope/vim-fugitive",
      require = {
        "tpope/vim-rhubarb", -- support github actions
        "rhysd/git-messenger.vim", -- explore git log messages
        "gisphm/vim-gitignore", -- .gitignore syntax highlighting and snippets
      },
    }

    use { -- super fast git decorations for the left gutter
      "lewis6991/gitsigns.nvim",
      config = plugin_defaults "gitsigns",
    }

    use { -- indentation guidelines
      "lukas-reineke/indent-blankline.nvim",
      config = plugin_defaults "indent_blankline",
    }

    use { -- fuzzy finder
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = {
        "nvim-lua/plenary.nvim",
        -- extensions
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-github.nvim",
        "nvim-telescope/telescope-packer.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "ThePrimeagen/harpoon", -- navigating marks quickly and easily
      },
      config = plugin_config "telescope",
    }

    use { -- find, display, and open buffer and plugin URLs
      "axieax/urlview.nvim",
      config = plugin_defaults "urlview",
    }

    use { -- fancy configurable notification manager
      "rcarriga/nvim-notify",
      config = plugin_defaults "notify",
    }

    use { -- code outline view for skimming and quick navigation
      "stevearc/aerial.nvim",
      config = plugin_config "aerial",
    }

    use { -- distraction-free coding
      "folke/zen-mode.nvim",
      config = plugin_config "zen-mode",
    }

    use { -- dim other areas of the code when editing (used by zen-mode)
      "folke/twilight.nvim",
      config = plugin_defaults "twilight",
    }

    use { -- clean neovim window (and tmux pane) operations
      "declancm/windex.nvim",
      config = plugin_defaults "windex",
    }

    use { -- smooth scrolling for any movement command
      "declancm/cinnamon.nvim",
      config = plugin_defaults "cinnamon",
    }

    use { -- search NeoVim key-bindings, marks, registers, and presets
      "folke/which-key.nvim",
      config = plugin_defaults "which-key",
    }

    use { -- pretty diagnostics, references, results, quickfix, and location lists
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = plugin_defaults "trouble",
    }

    use { -- alternative status update UI
      "j-hui/fidget.nvim",
      config = plugin_defaults "fidget",
    }

    use { -- buffer/mark/tabpage/colorscheme switcher
      "toppair/reach.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = plugin_defaults "reach",
    }

    use { -- snazzy bufferline with tabpage integration
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      requires = "nvim-tree/nvim-web-devicons",
      config = plugin_defaults "bufferline",
    }

    use { -- highlight current line & underline occurrences of word under cursor
      "yamatsum/nvim-cursorline",
      config = plugin_defaults "nvim-cursorline",
    }

    use { -- fancier statusbar
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = plugin_config "lualine",
    }

    use { -- Create Color Code - super powerful color picker / colorizer
      "uga-rosa/ccc.nvim",
      config = plugin_config "ccc",
    }

    -- some modern colorscheme options

    local use_cs = function(spec)
      if type(spec) == "string" then
        spec = { spec }
      end

      local packer_util = require "packer.util"
      local name, _ = packer_util.get_plugin_short_name(spec)

      spec.as = "cs-" .. name

      use(spec)
    end

    -- colorschemes : dark-only : single
    use_cs "AlessandroYorba/Alduin"
    -- use_cs "Everblush/everblush.nvim"
    -- use_cs "Mofiqul/dracula.nvim"
    -- use_cs "PHSix/nvim-hybrid"
    -- use_cs "Yazeed1s/minimal.nvim"
    -- use_cs "andersevenrud/nordic.nvim"
    -- use_cs { "bkegley/gloombuddy", requires = "tjdevries/colorbuddy.nvim" }
    -- use_cs "bluz71/vim-moonfly-colors"
    -- use_cs "bluz71/vim-nightfly-colors"
    -- use_cs { "chrsm/paramount-ng.nvim", requires = "rktjmp/lush.nvim" }
    -- use_cs "cpea2506/one_monokai.nvim"
    -- use_cs "fenetikm/falcon"
    -- use_cs "glepnir/zephyr-nvim"
    use_cs "JoosepAlviste/palenightfall.nvim"
    -- use_cs "kaiuri/nvim-juliana"
    -- use_cs "kvrohit/mellow.nvim"
    -- use_cs "kvrohit/rasmus.nvim"
    -- use_cs "kvrohit/substrata.nvim"
    -- use_cs "kyazdani42/blue-moon"
    -- use_cs "luisiacc/gruvbox-baby"
    -- use_cs "mrjones2014/lighthaus.nvim"
    -- use_cs "nxvu699134/vn-night.nvim"
    -- use_cs "ofirgall/ofirkai.nvim"
    -- use_cs "olivercederborg/poimandres.nvim"
    use_cs "paulfrische/reddish.nvim"
    -- use_cs "phha/zenburn.nvim"
    -- use_cs "rafamadriz/neon"
    use_cs "ray-x/aurora"
    -- use_cs { "rockyzhang24/arctic.nvim", requires = "rktjmp/lush.nvim" }
    -- use_cs "sainnhe/sonokai"
    use_cs "sam4llis/nvim-tundra"
    -- use_cs "shaunsingh/moonlight.nvim"
    -- use_cs "theniceboy/nvim-deus"
    -- use_cs "tiagovla/tokyodark.nvim"
    -- use_cs "tomasiser/vim-code-dark"
    -- use_cs "yashguptaz/calvera-dark.nvim"
    -- use_cs "yonlu/omni.vim"

    -- colorschemes : auto-switching : single
    -- use_cs "Mofiqul/adwaita.nvim"
    -- use_cs "Mofiqul/vscode.nvim"
    -- use_cs "NTBBloodbath/doom-one.nvim"
    -- use_cs "Th3Whit3Wolf/one-nvim"
    -- use_cs { "Th3Whit3Wolf/onebuddy", requires = "tjdevries/colorbuddy.nvim" }
    -- use_cs "Th3Whit3Wolf/space-nvim"
    -- use_cs { "adisen99/apprentice.nvim", requires = "rktjmp/lush.nvim" }
    -- use_cs { "adisen99/codeschool.nvim", requires = "rktjmp/lush.nvim" }
    -- use_cs "frenzyexists/aquarium-vim"
    -- use_cs "jim-at-jibba/ariake-vim-colors"
    use_cs "kdheepak/monochrome.nvim"
    -- use_cs "lourenci/github-colors"
    -- use_cs "morhetz/gruvbox"
    -- use_cs "olimorris/onedarkpro.nvim"
    -- use_cs { "pradyungn/Mountain", as = "mountain", rtp = "vim" }
    -- use_cs { "rebelot/kanagawa.nvim", config = plugin_defaults "kanagawa" }
    -- use_cs "rmehri01/onenord.nvim"
    use_cs { "rose-pine/neovim", as = "rose-pine" }
    -- use_cs "sainnhe/everforest"
    -- use_cs "savq/melange"
    use_cs "shaunsingh/nord.nvim"
    -- use_cs "shaunsingh/solarized.nvim"
    -- use_cs { "ramojus/mellifluous.nvim", requires = "rktjmp/lush.nvim" }
    use_cs "zanglg/nova.nvim"

    -- colorschemes : collections
    -- use_cs "EdenEast/nightfox.nvim"
    -- use_cs { "catppuccin/nvim", as = "catppuccin" }
    -- use_cs "ishan9299/modus-theme-vim"
    -- use_cs "ishan9299/nvim-solarized-lua"
    -- use_cs "ldelossa/vimdark"
    -- use_cs "projekt0n/github-nvim-theme"
    -- use_cs "rockerBOO/boo-colorscheme-nvim"
    -- use_cs "tanvirtin/monokai.nvim"

    -- colorschemes : collections + auto-switching
    use_cs "Shatur/neovim-ayu"
    use_cs "folke/tokyonight.nvim"

    -- colorschemes : collections + randomizer
    -- use_cs { "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" }
    -- use_cs "ray-x/starry.nvim"

    -- colorschemes : collections w/ custom configuration techniques
    -- use_cs "lmburns/kimbox"
    -- use_cs "marko-cerovac/material.nvim"
    -- use_cs "navarasu/onedark.nvim"
    -- use_cs "sainnhe/edge"
    -- use_cs "sainnhe/gruvbox-material"

    use { -- quick and easy colorscheme switcher, which persists
      "jamesiain/colorscheme-persist.nvim",
      requires = {
        "nvim-telescope/telescope-dap.nvim",
        "folke/lsp-colors.nvim",
      },
      config = plugin_config "colorscheme-persist",
    }

    -- put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync() -- automatically setup new configuration
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = { -- record startup time information for plugins
      enable = true, -- use ":PackerProfile" to view the output
    },
  },
}
