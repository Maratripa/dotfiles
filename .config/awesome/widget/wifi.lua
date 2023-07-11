local awful = require 'awful'
local gears = require 'gears'
local gfs = require 'gears.filesystem'
local naughty = require 'naughty'
local wibox = require 'wibox'

local HOME = os.getenv('HOME')

local wifi_widget = {}
local function worker(user_args)
    local args = user_args or {}
    local path_to_icons = args.path_to_icons or HOME .. '/.config/awesome/theme/icons/wifi/'
    local timeout = args.timeout or 5

    if not gfs.dir_readable(path_to_icons) then
        naughty.notification {
            title = 'Wifi Widget',
            text = 'Folder with icons doesn\'t exist: ' .. path_to_icons,
            preset = naughty.config.presets.critical
        }
    end

    local icon_widget = wibox.widget {
        {
            id = "icon",
            widget = wibox.widget.imagebox,
            resize = false,
            scaling_quality = 'best',
            max_scaling_factor = 1,
        },
        valign = 'center',
        layout = wibox.container.place,
    }

    wifi_widget = icon_widget

    local status = "awk 'NR==3 {printf(\"%.0f\",$3*10/7)}' /proc/net/wireless"

    local wifi_type = 'wifi_slash'

    awful.widget.watch(status, timeout, function(widget, stdout)
        local connected
        local strength = tonumber(stdout)

        if not strength then
            connected = false
            strength = 0
        else
            connected = true
        end

        if (strength >= 0 and strength < 25) then
            wifi_type = 'wifi_none'
        elseif (strength >= 25 and strength < 50) then
            wifi_type = 'wifi_low'
        elseif (strength >= 50 and strength < 75) then
            wifi_type = 'wifi_medium'
        elseif (strength >= 75 and strength <= 100) then
            wifi_type = 'wifi_high'
        end

        if not connected then
            wifi_type = 'wifi_x'
        end

        local icon = gears.color.recolor_image(path_to_icons .. wifi_type .. ".svg", "#FFFFFF")
        widget.icon:set_image(icon)
    end, wifi_widget)

    return wibox.container.margin(wifi_widget, 0, 0)
end

return setmetatable(wifi_widget, { __call = function(_, ...) return worker(...) end })
