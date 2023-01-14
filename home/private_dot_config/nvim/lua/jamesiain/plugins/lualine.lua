local lualine_ok, lualine = pcall(require, "lualine")

if not lualine_ok then
  return
end

local function maximize_status()
  return vim.t.maximized and " " or ""
end

local function navic_location()
  local navic_ok, navic = pcall(require, "nvim-navic")

  if navic_ok and navic.is_available() then
    return navic.get_location()
  else
    return ""
  end
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_c = {
      maximize_status,
      navic_location,
    },
  },
}
