local awful = require 'awful'
local gears = require 'gears'
local gfs = require 'gears.filesystem'
local naughty = require 'naughty'
local wibox = require 'wibox'

local HOME = os.getenv('HOME')

local volume_widget = {}
local function worker(user_args)
    local args = user_args or {}
    local path_to_icons = args.path_to_icons or HOME .. '/.config/awesome/theme/icons/volume/'
    local timeout = args.timeout or 2

    if not gfs.dir_readable(path_to_icons) then
        naughty.notification {
            title = 'Volume Widget',
            text = 'Folder with icons doesn\'t exist: ' .. path_to_icons,
            preset = naughty.config.presets.critical,
        }
    end

    local icon_widget = wibox.widget {
        {
            id = 'icon',
            resize = false,
            scaling_quality = 'best',
            max_scaling_factor = 1,
            widget = wibox.widget.imagebox,
        },
        valign = 'center',
        layout = wibox.container.place,
    }

    volume_widget = icon_widget

    local status = "pactl get-sink-volume @DEFAULT_SINK@"

    local volume_type = 'speaker-slash-fill'

    awful.widget.watch(status, timeout, function(widget, stdout)
        MUTED = {}
        awful.spawn.easy_async("pactl get-sink-mute @DEFAULT_SINK@", function(out)
            if out:find('no') then
                MUTED.status = false
            else
                MUTED.status = true
            end
        end)

        local volume = tonumber(stdout:match("([%d]*)%%"))

        if not volume then
            volume = 0
        end

        if (volume > 0 and volume < 20) then
            volume_type = 'speaker-none-fill'
        elseif (volume >= 20 and volume < 50) then
            volume_type = 'speaker-low-fill'
        elseif (volume >= 50) then
            volume_type = 'speaker-high-fill'
        end

        if MUTED.status then
            volume_type = 'speaker-x-fill'
        end

        local icon
        if volume >= 100 then
            icon = gears.color.recolor_image(path_to_icons .. volume_type .. '.svg', '#FF0000')
        else
            icon = gears.color.recolor_image(path_to_icons .. volume_type .. '.svg', '#FFFFFF')
        end

        widget.icon:set_image(icon)
    end, volume_widget)

    volume_widget:connect_signal('button::press', function(_, _, _, button)
        if (button == 3) then awful.spawn('pavucontrol') end
    end)

    return wibox.container.margin(volume_widget, 0, 0)
end

return setmetatable(volume_widget, { __call = function(_, ...) return worker(...) end })
