local colorscheme = {
    black = "#000000",

    white = "#ffffff",

    colors = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe"
    },

    fg = {
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
    },

    bg = {
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b"
    }
}

return {
    bg_normal = colorscheme.bg.mantle,
    bg_dark = colorscheme.bg.crust,
    bg_light = colorscheme.bg.base,
    bg_very_light = colorscheme.bg.surface0,

    fg_normal = colorscheme.fg.text,
    fg_dark = colorscheme.fg.subtext1,
    bg_very_dark = colorscheme.fg.subtext0,

    -- black
    black = colorscheme.bg.surface1,
    black_alt = colorscheme.bg.surface2,

    -- red
    red = colorscheme.colors.red,
    red_alt = colorscheme.colors.maroon,

    -- green
    green = colorscheme.colors.green,
    green_alt = colorscheme.colors.teal,

    -- yellow
    yellow = colorscheme.colors.peach,
    yellow_alt = colorscheme.colors.yellow,

    -- blue
    blue = colorscheme.colors.blue,
    blue_alt = colorscheme.colors.lavender,

    -- magenta
    purple = colorscheme.colors.mauve,
    purple_alt = colorscheme.colors.pink,

    -- cyan
    cyan = colorscheme.colors.sky,
    cyan_alt = colorscheme.colors.sapphire,

    -- white
    white = colorscheme.fg.overlay0,
    white_alt = colorscheme.fg.overlay1,
}
