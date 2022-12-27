local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

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
            maximized = false,
        }
    },

    -- Floating clients
    {
        rule_any = {
            class = {
                "Blueman-manager"
            },
            role = {
                "pop-up"
            }
        },
        properties = {floating = true}
    },

    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = false}
    }
}