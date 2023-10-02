local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')
local beautiful = require("beautiful")

awful.rules.rules = {
    -- All clients will match this rule
    {
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_offscreen + awful.placement.no_overlap,
        }
    },

    -- Floating clients
    {
        rule_any = {
            class = {
                "Blueman-manager",
                "GitHub.UI",
                "qemu",
                "Nm-connection-editor",
                "Nvidia-settings",
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileCooserDialog",
            },
            type = {
                "dialog",
            }
        },
        properties = { floating = true }
    },

    {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false }
    },

    {
        rule_any = { class = { "steam" } },
        properties = { floating = true }
    },

    -- Image viewers
    {
        rule_any = {
            class = {
                "feh",
            }
        },
        properties = {
            floating = true,
        }
    },

    -- Pavucontrol
    {
        rule = { class = "Pavucontrol" },
        properties = { floating = true },
        callback = function(c)
            c.width = 650
            c.height = 400
            awful.placement.top_right(c, {
                margins = {
                    top = beautiful.bar_height + 5,
                    right = 5,
                }
            })
        end
    }
}
