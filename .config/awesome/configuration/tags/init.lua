local awful = require('awful')
local beautiful = require('beautiful')

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

awful.screen.connect_for_each_screen(function(s)
    for i = 1, 5 do
        awful.tag.add(
            i,
            {
                layout = awful.layout.suit.tile,
                gap_single_client = true,
                gap = beautiful.useless_gap,
                screen = s,
                selected = i == 1
            }
        )
    end
end)
