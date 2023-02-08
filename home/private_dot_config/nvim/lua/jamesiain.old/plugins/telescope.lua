local telescope_ok, telescope = pcall(require, "telescope")
local dap_ok, _ = pcall(require, "dap")
local harpoon_ok, harpoon = pcall(require, "harpoon")

if not telescope_ok then
  return
end

telescope.setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
}

telescope.load_extension "fzy_native"
telescope.load_extension "file_browser"
telescope.load_extension "ui-select"
telescope.load_extension "gh"
telescope.load_extension "packer"
if dap_ok then telescope.load_extension "dap" end
if harpoon_ok then telescope.load_extension "harpoon" end

local builtin = require "telescope.builtin"
local themes = require "telescope.themes"
local set = vim.keymap.set

set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
set("n", "<leader>/", function()
  -- you can pass additional configuration to telescope to change theme, layout, etc...
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch using [G]rep" })
set("n", "<leader>sd", builtin.buffers, { desc = "[S]earch [D]iagnostics" })

if harpoon_ok then
  harpoon.setup {
    global_settings = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`
      save_on_toggle = true,
    },
  }

  local harpoon_mark = require "harpoon.mark"
  local harpoon_ui = require "harpoon.ui"

  set("n", "<leader>ht", "<CMD>Telescope harpoon marks<CR>", { desc = "[H]arpoon: Show Marks in [T]elescope" })
  set("n", "<leader>hr", function() harpoon_mark.add_file() end, { desc = "[H]arpoon: Set a Ma[r]k" })
  set("n", "<leader>hq", function() harpoon_ui.toggle_quick_menu() end, { desc = "[H]arpoon: Toggle the [Q]uick Menu" })
  set("n", "<leader>hf", function() harpoon_ui.nav_file(1) end, { desc = "[H]arpoon: Navigate to Mark 1" })
  set("n", "<leader>hd", function() harpoon_ui.nav_file(2) end, { desc = "[H]arpoon: Navigate to Mark 2" })
  set("n", "<leader>hs", function() harpoon_ui.nav_file(3) end, { desc = "[H]arpoon: Navigate to Mark 3" })
  set("n", "<leader>ha", function() harpoon_ui.nav_file(4) end, { desc = "[H]arpoon: Navigate to Mark 4" })
end
