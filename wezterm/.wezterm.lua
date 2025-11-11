local wezterm = require("wezterm")

-- Кастомная Kanagawa цветовая схема для максимальной аутентичности
local kanagawa_colors = {
    foreground = "#DCD7BA",
    background = "#1F1F28",

    cursor_bg = "#C8C093",
    cursor_fg = "#1F1F28",
    cursor_border = "#C8C093",

    selection_fg = "#C8C093",
    selection_bg = "#2D4F67",

    scrollbar_thumb = "#16161D",
    split = "#16161D",

    ansi = {
        "#090618", -- black
        "#C34043", -- red
        "#76946A", -- green
        "#C0A36E", -- yellow
        "#7E9CD8", -- blue
        "#957FB8", -- magenta
        "#6A9589", -- cyan
        "#C8C093", -- white
    },
    brights = {
        "#727169", -- bright black
        "#E82424", -- bright red
        "#98BB6C", -- bright green
        "#E6C384", -- bright yellow
        "#7FB4CA", -- bright blue
        "#938AA9", -- bright magenta
        "#7AA89F", -- bright cyan
        "#DCD7BA", -- bright white
    },

    indexed = {
        [16] = "#FFA066",
        [17] = "#FF5D62",
    },

    tab_bar = {
        background = "#1F1F28",
        active_tab = {
            bg_color = "#2D4F67",
            fg_color = "#DCD7BA",
        },
        inactive_tab = {
            bg_color = "#1F1F28",
            fg_color = "#727169",
        },
        inactive_tab_hover = {
            bg_color = "#223249",
            fg_color = "#DCD7BA",
        },
        new_tab = {
            bg_color = "#1F1F28",
            fg_color = "#727169",
        },
        new_tab_hover = {
            bg_color = "#223249",
            fg_color = "#DCD7BA",
        },
    },
}

return {
    -- МАКСИМАЛЬНАЯ ПРОИЗВОДИТЕЛЬНОСТЬ
    front_end = "WebGpu",
    webgpu_power_preference = "HighPerformance",
    max_fps = 120, -- Увеличил с 60 до 120 для плавности
    animation_fps = 60, -- Увеличил с 1 для плавных анимаций

    -- Оптимизация рендеринга
    scrollback_lines = 5000, -- Меньше истории = быстрее
    enable_scroll_bar = false,

    -- ЯПОНСКИЙ СТИЛЬ KANAGAWA
    colors = kanagawa_colors,

    -- Элегантный шрифт с улучшенным рендерингом
    font = wezterm.font_with_fallback({
        { family = "JetBrainsMono Nerd Font", weight = "Regular" },
        { family = "Iosevka Nerd Font Mono", weight = "Regular" },
        "Symbols Nerd Font Mono",
        "Noto Color Emoji",
    }),
    font_size = 14.0,
    line_height = 1.2,
    cell_width = 1.0,
    freetype_load_target = "Normal",
    freetype_render_target = "HorizontalLcd",

    -- ПИЗДАТЫЙ МИГАЮЩИЙ КУРСОР
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 530, -- Оптимальная скорость мигания
    cursor_blink_ease_in = "EaseIn",
    cursor_blink_ease_out = "EaseOut",
    cursor_thickness = "1pt",

    -- Прозрачность в стиле японского минимализма
    window_background_opacity = 0.92, -- Увеличил с 0.4 для читаемости
    text_background_opacity = 1.0, -- Текст полностью непрозрачный
    macos_window_background_blur = 20, -- Blur эффект для macOS

    -- Минималистичный UI
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    native_macos_fullscreen_mode = true,
    window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 8,
    },

    -- Оптимизация производительности
    check_for_updates = false,
    automatically_reload_config = true,
    use_dead_keys = false,
    enable_kitty_keyboard = false,

    -- Shell
    default_prog = { "/bin/zsh", "-l" },

    -- Важно для работы Alt-клавиш на macOS
    send_composed_key_when_left_alt_is_pressed = false,
    send_composed_key_when_right_alt_is_pressed = true,

    -- Хоткеи для быстрого открытия vim (Cmd на macOS)
    keys = {
        -- Сохраняем старый хоткей
        {
            key = 'f',
            mods = 'CTRL',
            action = wezterm.action.SpawnCommandInNewTab {
                args = { "/bin/zsh", "-i", "-l", "/Users/valerycherneykin/bin/dev.sh" },
            },
        },
        -- Cmd+E - nvim в текущей директории (аналог ve)
        {
            key = 'e',
            mods = 'CMD',
            action = wezterm.action.SendString('nvim .\r'),
        },
        -- Cmd+Shift+V - просто nvim (аналог v)
        {
            key = 'V',
            mods = 'CMD|SHIFT',
            action = wezterm.action.SendString('nvim\r'),
        },
        -- Cmd+, - nvim config (стандартный хоткей настроек на Mac)
        {
            key = ',',
            mods = 'CMD',
            action = wezterm.action.SendString('nvim ~/.config/nvim\r'),
        },
        -- Cmd+Shift+W - wezterm config
        {
            key = 'W',
            mods = 'CMD|SHIFT',
            action = wezterm.action.SendString('nvim ~/.wezterm.lua\r'),
        },
        -- Cmd+Shift+T - tmux config
        {
            key = 'T',
            mods = 'CMD|SHIFT',
            action = wezterm.action.SendString('nvim ~/.tmux.conf\r'),
        },
        -- Cmd+Shift+Z - zsh config
        {
            key = 'Z',
            mods = 'CMD|SHIFT',
            action = wezterm.action.SendString('nvim ~/.zshrc\r'),
        },
    },

    -- Дополнительные оптимизации
    bold_brightens_ansi_colors = true,

    -- Улучшенная обработка Unicode для японских символов
    unicode_version = 14,

    -- Быстрая отрисовка
    enable_wayland = false,
}
