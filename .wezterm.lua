local wezterm = require("wezterm")

return {
  color_scheme = "Tokyo Night",

  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
  font_size = 14,

  window_background_image = 'path/to/image',
  window_background_image_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  window_background_opacity = 0.3,
  text_background_opacity = 0.7,

  keys = {
    { key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  },

  window_decorations = "RESIZE",
  native_macos_fullscreen_mode = true,

  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    pane:send_text("tmux new-session -As main 'neofetch; exec zsh'\n")
  end),
}
