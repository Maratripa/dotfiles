local menubar = require("menubar")

local apps = {
    default = {
        terminal = "wezterm",
        editor = "code-insiders",
        browser = "firefox-developer-edition",
        files = "thunar",
        launcher = "./.config/rofi/scripts/launcher_t1",
    },

    run_on_start_up = {
        "nm-applet --indicator",
        "blueman-applet"
    }
}

menubar.utils.terminal = apps.default.termianl

return apps