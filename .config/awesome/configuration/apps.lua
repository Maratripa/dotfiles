local menubar = require("menubar")

local apps = {
    default = {
        terminal = "wezterm",
        editor = "vscodium",
        browser = "floorp",
        files = "thunar",
        launcher = "rofi -no-config -show drun -theme ~/.config/rofi/launcher.rasi",
    },

    run_on_start_up = {
        "nm-applet --indicator",
        "blueman-applet"
    }
}

menubar.utils.terminal = apps.default.termianl

return apps
