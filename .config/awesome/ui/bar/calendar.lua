---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'

local dpi = beautiful.xresources.apply_dpi

local function get_calendar()
    return awful.screen.focused().calendar
end

awesome.connect_signal("calendar::toggle", function()
    if awful.screen.focused().calendar then
        get_calendar().toggle()
    end
end)

awesome.connect_signal("calendar::visibility", function(v)
    if v then
        get_calendar().show()
    else
        get_calendar().hide()
    end
end)

awful.screen.connect_for_each_screen(function(s)
    local styles = {}
    local function rounded_shape(radius)
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, radius)
        end
    end

    local function circle(radius)
        return function(cr, width, height)
            gears.shape.circle(cr, width, height, radius)
        end
    end

    styles.month = {
        padding = 10,
    }
    styles.normal = { shape = rounded_shape(5) }
    styles.focus = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.colors.green .. "b0",
        markup = function(t) return "<b>" .. t .. "</b>" end,
        shape = circle(13),
    }
    styles.header = {
        fg_color = beautiful.colors.blue,
        markup = function(t) return "<b>" .. t .. "</b>" end,
    }
    styles.weekday = {
        fg_color = beautiful.colors.blue_alt,
    }

    local function decorate_cell(widget, flag, date)
        if flag == "monthheader" and not styles.monthheader then
            flag = "header"
        end

        if flag == "normal" or flag == "focus" then
            widget = wibox.widget {
                text = date.day,
                align = "center",
                widget = wibox.widget.textbox,

            }
        end

        local props = styles[flag] or {}
        if props.markup and widget.get_text and widget.set_markup then
            widget:set_markup(props.markup(widget:get_text()))
        end

        -- Change bg color for weekends
        local d = {
            year = date.year,
            month = (date.month or 1),
            day = (date.day or 1)
        }
        -- local weekday = tonumber(os.date("%w", os.time(d)))
        local ret = wibox.widget {
            {
                widget,
                margins = (props.padding or 2),
                halign = "center",
                widget = wibox.container.margin,
            },
            align = "center",
            shape = props.shape,
            border_color = props.border_color or beautiful.bg_normal,
            border_width = props.border_width or 0,
            fg = props.fg_color or "#ffffff",
            bg = props.bg_color or beautiful.bg_normal,
            widget = wibox.container.background,
        }

        return ret
    end

    s.calendar = {}

    s.calendar.widget = wibox.widget {
        date = os.date("*t"),
        fn_embed = decorate_cell,
        font = beautiful.font_name .. "20",
        long_weekdays = true,
        widget = wibox.widget.calendar.month,
    }

    s.calendar.popup = awful.popup {
        widget = s.calendar.widget,
        screen = s,
        visible = false,
        ontop = true,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        minimum_width = dpi(150),
        minimum_height = dpi(150),
        shape = gears.shape.rounded_rect,
        placement = function(d)
            return awful.placement.top_right(d, {
                margins = {
                    right = dpi(80),
                    top = dpi(54),
                }
            })
        end,
    }

    local self, calendar = s.calendar.popup, s.calendar

    function calendar.toggle()
        if self.visible then
            calendar.hide()
        else
            calendar.show()
        end
    end

    function calendar.show()
        self.visible = true
    end

    function calendar.hide()
        self.visible = false
    end
end)
