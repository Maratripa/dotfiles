local menubar = require("menubar")

local apps = {
    default = {
        terminal = "wezterm",
        editor = "code-insiders",
        browser = "firefox-developer-edition",
        files = "thunar",
        launcher = "rofi -show drun",
    },

    run_on_start_up = {
        "nm-applet --indicator",
        "blueman-applet"
    }
}

menubar.utils.terminal = apps.default.termianl

return apps