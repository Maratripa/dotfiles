local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local update_tags = function(self, index, s)
    local markup_role = self:get_children_by_id("markup_role")[1]

    local found = false
    local i = 1

    while i <= #s.selected_tags do
        if s.selected_tags[i].index == index then
            found = true
        end
        i = i + 1
    end

    if found then
        markup_role.image = gears.color.recolor_image(
            beautiful.selected_tag_format,
            beautiful.taglist_fg_focus
        )
    else
        markup_role.image = gears.color.recolor_image(
            beautiful.normal_tag_format,
            beautiful.taglist_fg
        )
        for _, c in ipairs(_G.client.get(s)) do
            for _, t in ipairs(c:tags()) do
                if t.index == index then
                    markup_role.image = gears.color.recolor_image(
                        beautiful.occupied_tag_format,
                        beautiful.taglist_fg_occupied
                    )
                end
            end
        end
    end
end

local get_taglist = function(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            layout = wibox.layout.fixed.horizontal,
        },
        style = {
            shape = gears.shape.circle,
        },
        buttons = {
            awful.util.table.join(
                awful.button({}, 1, function(t)
                    t:view_only()
                    end
                ),
                awful.button({}, 4, function(t)
                    awful.tag.viewprev(t.screen)
                    end
                ),
                awful.button({}, 5, function(t)
                    awful.tag.viewnext(t.screen)
                    end
                )
            ),
        },
        widget_template = {
            {
                {
                    id = "markup_role",
                    image = nil,
                    valign = "center",
                    halign = "center",
                    forced_height = 16,
                    forced_width = 16,
                    widget = wibox.widget.imagebox,
                },
                id = "background_role",
                widget = wibox.container.background,
                shape = gears.shape.circle,
            },
            id = "",
            widget = wibox.container.margin,
            left = 15,
            update_callback = function (self, _, index)
                update_tags(self, index, s)
            end,
            create_callback = function (self, _, index)
                update_tags(self, index, s)
            end,
        },
    }
end

return get_taglist