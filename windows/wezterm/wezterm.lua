local wezterm = require 'wezterm'

return {
  -- default_prog = { "cmd.exe" },

  default_prog = { "nu.exe" },
  font = wezterm.font_with_fallback({
    {family = 'MonoLisa', weight = 'Medium'},
    'Dank Mono',
    'JetBrainsMono NF',
    'Cascadia Code',
    'Cartograph CF',
  }),
  font_size = 13,
  window_frame = {
  		-- The font used in the tab bar.
  		-- Roboto Bold is the default; this font is bundled
  		-- with wezterm.
  		-- Whatever font is selected here, it will have the
  		-- main font setting appended to it to pick up any
  		-- fallback fonts you may have used there.
  		font = wezterm.font({ family = "Cascadia Code Semibold" }),

  		-- The size of the font in the tab bar.
  		-- Default to 10. on Windows but 12.0 on other systems
  		font_size = 12.0,

  		-- The overall background color of the tab bar when
  		-- the window is focused
  		active_titlebar_bg = "#333333",

  		-- The overall background color of the tab bar when
  		-- the window is not focused
  		inactive_titlebar_bg = "#333333",

  	},
  keys = {
    {
      key = 'C',
      mods = 'CTRL',
      action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
    { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
  },
  force_reverse_video_cursor = true,
  window_background_opacity = 0.6,
  colors = {
    foreground = "#dcd7ba",
    --background = "#1f1f28",
    background = "#000000",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
}
