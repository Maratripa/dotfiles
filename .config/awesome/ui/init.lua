local awful = require('awful')

local taglist = require("ui.taglist")
local systemtray_panel = require("ui.systemtray-panel")
local datetime_panel = require("ui.datetime-panel")

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function (s)
    s.taglist = taglist(s, true)
    s.systemtray_panel = systemtray_panel(s, true)
    s.datetime_panel = datetime_panel(s, true)
end)

-- Hide bars when app go fullscreen
local updateBarsVisibility = function ()
    for s in _G.screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreenMode
            s.taglist.visible = not fullscreen
            s.systemtray_panel.visible = not fullscreen
            s.datetime_panel.visible = not fullscreen
        end
    end
end

_G.tag.connect_signal('property::selected',
                      function(t) updateBarsVisibility() end)

_G.client.connect_signal('property::fullscreen', function(c)
    c.screen.selected_tag.fullscreenMode = c.fullscreen
    updateBarsVisibility()
end)

_G.client.connect_signal('unmanage', function(c)
    if c.fullscreen then
        c.screen.selected_tag.fullscreenMode = false
        updateBarsVisibility()
    end
end)