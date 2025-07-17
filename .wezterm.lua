local wezterm = require("wezterm")

return {
    color_scheme = "Tokyo Night Storm",
    font = wezterm.font_with_fallback({
        { family = "JetBrainsMono Nerd Font", weight = "Regular" },
        "Symbols Nerd Font Mono",
        "Noto Color Emoji",
    }),
    font_size = 14.0,
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",


    front_end = "WebGpu",
    max_fps = 60,
    animation_fps = 1,

    -- window_background_image = "/path/image",
    -- window_background_image_hsb = {
    --     hue = 1.0,
    --     saturation = 1,
    --     brightness = 0.8,
    -- },

    window_background_opacity = 0.92,
    text_background_opacity = 1.0,

    enable_tab_bar = false,
    enable_scroll_bar = false,
    window_decorations = "RESIZE",
    native_macos_fullscreen_mode = true,

    check_for_updates = false,
    use_dead_keys = false,
    enable_kitty_keyboard = false,

    default_prog = { "/bin/zsh", "-l" },
    keys = {
        {
            key = 'f',
            mods = 'CTRL',
            action = wezterm.action.SpawnCommandInNewTab {
                args = { "/bin/zsh", "-i", "-l", "~/bin/dev.sh" },
            },
        },
    },

    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 500,
}
