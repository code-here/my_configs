
local colors = require("colors")
local wezterm = require("wezterm")

local M = {}

M.merge = function(first_table, second_table)
  for k, v in pairs(second_table) do first_table[k] = v end
  return first_table
end


M.get_process_name = function(tab)
  local process_name = tab.active_pane.user_vars.PROG

  if process_name == nil then
    process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
  end

  if process_name == "wslhost.exe" then
    local pane = tab.active_pane
    process_name = pane.title
  end

  if process_name == "" then
    process_name = "zsh"
  end

  return process_name
end

M.get_process = function(tab)
  local process_icons = {
    ["docker.exe"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["docker-compose.exe"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["nvim.exe"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["v.exe"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["vim.exe"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.dev_vim },
    },
    ["node.exe"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.mdi_hexagon },
    },
    ["zsh.exe"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["bash.exe"] = {
      { Foreground = { Color = colors.subtext0 } },
      { Text = wezterm.nerdfonts.cod_terminal_bash },
    },
    ["htop.exe"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
    },
    ["cargo.exe"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_rust },
    },
    ["go.exe"] = {
      { Foreground = { Color = colors.sapphire } },
      { Text = wezterm.nerdfonts.mdi_language_go },
    },
    ["lazydocker.exe"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["git.exe"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lazygit.exe"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lua.exe"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.seti_lua },
    },
    ["wget.exe"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_arrow_down_box },
    },
    ["curl.exe"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_flattr },
    },
    ["gh.exe"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = wezterm.nerdfonts.dev_github_badge },
    },
  }

  local process_name = M.get_process_name(tab)

  return wezterm.format(
    process_icons[process_name]
    or { { Foreground = { Color = colors.lavender} }, { Text = string.format("%s", process_name) } }
  )
end



return M;