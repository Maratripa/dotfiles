local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")

local default_icon = ''

local app_config = {
    ['screenshot'] = { icon = '', title = true },
    ['Spotify'] = { icon = '', title = true },
    ['battery'] = { icon = '', title = false },
    ['charger'] = { icon = '', title = false },
    ['volume'] = { icon = '', title = false },
    ['brightness'] = { icon = '', title = false },
    ['Telegram Desktop'] = { icon = '', title = false },
    ['NetworkManager'] = { icon = '', title = false },
}

local urgency_color = {
    ['low'] = beautiful.fg_normal,
    ['normal'] = beautiful.fg_normal,
    ['critical'] = beautiful.red,
}

-- Template
naughty.connect_signal("request::display", function(n)
    local custom_notification_icon = wibox.widget {
        font = "Phosphor-Fill 22",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local color = urgency_color[n.urgency]

    local icon, title_visible

    if app_config[n.app_name] then
        icon = app_config[n.app_name].icon
        title_visible = app_config[n.app_name].title
    else
        icon = default_icon
        title_visible = true
    end

    local action_widget = {
        {
            {
                id = "text_role",
                align = "center",
                valign = "center",
                font = "Iosevka 11",
                widget = wibox.widget.textbox
            },
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_normal,
        forced_height = dpi(25),
        foced_width = dpi(20),
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, dpi(4))
        end,
        widget = wibox.container.background
    }

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(5),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = action_widget,
        style = {
            underline_normal = false,
            underline_selected = true
        },
        widget = naughty.list.actions
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        position = beautiful.notification_position,
        widget_template = wibox.widget {
            {
                {
                    {
                        markup = "<span foreground='" .. color .. "'>" .. icon .. "</span>",
                        align = "center",
                        valign = "center",
                        widget = custom_notification_icon
                    },
                    forced_width = dpi(50),
                    bg = beautiful.bg_normal,
                    widget = wibox.container.background
                },
                {
                    {
                        {
                            {
                                text = n.title,
                                font = "Iosevka Bold 11",
                                align = "center",
                                visible = title_visible,
                                widget = wibox.widget.textbox
                            },
                            {
                                text = n.message,
                                align = "center",
                                valign = "center",
                                font = "Iosevka 10",
                                widget = wibox.widget.textbox
                            },
                            {
                                actions,
                                visible = n.actions and #n.actions > 0,
                                layout = wibox.layout.fixed.vertical,
                                forced_width = dpi(220),
                            },
                            spacing = dpi(4),
                            layout = wibox.layout.fixed.vertical,
                        },
                        layout = wibox.layout.align.vertical
                    },
                    margins = dpi(8),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            shape = helpers.rrect(beautiful.border_radius),
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }
    }
end)

local notifications = {}

-- Timeouts
naughty.config.defaults.timeout = 5
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 12


function notifications.notify_dwim(args, n)
    if n and not n._private.is_destroyed and not n.is_expired then
        n.title = args.title or n.title
        n.message = args.message or n.message
        n.icon = args.icon or n.icon
        n.timeout = args.timeout or n.timeout
    else
        n = naughty.notification(args)
    end
    return n
end

function notifications.screenshot(filename)
    local open = naughty.action {
        name = "Open"
    }

    open:connect_signal("invoked", function(_)
        awful.spawn("feh " .. filename, false)
    end)

    local show = naughty.action {
        name = "Show in folder"
    }

    show:connect_signal("invoked", function(_)
        awful.spawn("thunar " .. filename .. "/..", false)
    end)

    naughty.notify({
        title = "Screenshot captured!",
        app_name = "screenshot",
        actions = { open, show },
        timeout = 10,
        urgency = "normal"
    })
end

return notifications
