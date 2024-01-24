local wezterm = require 'wezterm'
-- local mux = wezterm.mux
local utils = require("utils")
-- local colors = require("colors")

-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():set_position(12, 80)
--   pane:split { size = 0.7 }
--   pane:split { direction = 'Bottom' }
--   for i, p in ipairs(tab:panes()) do
--     if i == 3 then
--       p:activate()
--       break
--     end
--   end
-- end)

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "  ~"
      or string.format(" %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
  return wezterm.format({
    { Attribute = { Intensity = "Half" } },
    { Text = tab.is_active and " [" or "  " },
    { Text = utils.get_process(tab) },
    { Text = "  " },
    { Text = get_current_working_dir(tab) },
    { Text = tab.is_active and "] " or "  " },
    -- { Foreground = { Color = colors.base } },
  })
end)

wezterm.on("update-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.strftime("%H:%M ") },
  }))
end)

local os_config = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' or wezterm.target_triple == 'x86_64-pc-windows-gnu' then
  local wsl_domains = wezterm.default_wsl_domains()
  for _, dom in ipairs(wsl_domains) do
    dom.default_cwd = "/home/dark"
  end
  os_config = {
    wsl_domains = wsl_domains,
    default_domain = "WSL:Ubuntu",
  }
else
  os_config = {
    window_padding = {
      left = 20,
      right = 20,
      top = 20,
      bottom = 20,
    },
  }
end


return utils.merge({
  -- default_prog = { "nu" },
  font = wezterm.font_with_fallback({
    'Liga SFMono Nerd Font',
    'pragmasevka Nerd Font',
    'PragmataPro for Powerline',
    'Monolisa',
    'Anonymous Pro',
    'Input Mono Compressed',
    'Hack',
    'VictorMono Nerd Font',
    'JetBrainsMono Nerd Font',
    'CaskaydiaCove Nerd Font',
    'Iosevka Nerd Font',
    'FiraCode Nerd Font Mono',
  }),
  use_cap_height_to_scale_fallback_fonts = true,
  front_end = 'WebGpu',
  webgpu_power_preference = "HighPerformance",
  -- font_size = 13,
  -- cell_width = 1.0,
  max_fps = 120,
  initial_rows = 45,
  initial_cols = 208,
  pane_focus_follows_mouse = false,
  warn_about_missing_glyphs = false,
  show_update_window = true,
  check_for_updates = true,
  -- line_height = 1.1,
  window_decorations = "RESIZE",
  window_close_confirmation = "AlwaysPrompt",
  audible_bell = "Disabled",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
  },
  enable_scroll_bar = false,
  scrollback_lines = 10000,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  show_new_tab_button_in_tab_bar = false,
  window_background_opacity = 0.8,
  -- macos_window_background_blur = 20,
  tab_max_width = 50,
  hide_tab_bar_if_only_one_tab = true,
  disable_default_key_bindings = false,
  -- color_scheme = "Oxo carbon",
  color_scheme = "Gruvbox dark, hard (base16)",
  -- color_scheme = "ForestBlue",
  -- color_scheme = "rose-pine",
  -- color_scheme = "Everforest Dark (Gogh)",
  leader = { key = "a", mods = "CTRL" },
  keys = {
    -- Keybindings similar to tmux
    { key = "-",   mods = "LEADER",    action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "\\",  mods = "LEADER",    action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },

    --
    { key = "z",   mods = "LEADER",    action = "TogglePaneZoomState" },
    { key = "c",   mods = "LEADER",    action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    --
    { key = "n",   mods = "LEADER",    action = wezterm.action.ActivateTabRelative(1) },
    { key = "p",   mods = "LEADER",    action = wezterm.action.ActivateTabRelative(-1) },
    --
    { key = "h",   mods = "LEADER",    action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "l",   mods = "LEADER",    action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "k",   mods = "LEADER",    action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "j",   mods = "LEADER",    action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    --
    { key = "H",   mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 2 } }) },
    { key = "L",   mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 2 } }) },
    { key = "J",   mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 2 } }) },
    { key = "K",   mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 2 } }) },
    ---
    { key = 'P',   mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette, },
    { key = 'U',   mods = 'CMD|SHIFT', action = wezterm.action.Nop, },
    { key = 'F11', mods = '',          action = wezterm.action.ToggleFullScreen, },
    {
      key = 'C',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
  },
  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = "mailto:$0",
    },
    {
      regex = [[\bfile://\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b[tT](\d+)\b]],
      format = "https://example.com/tasks/?t=$1",
    },
  },
}, os_config)
