local awful = require('awful')

local workspace_panel = require("layout.workspace-panel")
local systemtray_panel = require("layout.systemtray-panel")
local clock_panel = require("layout.clock-panel")
local date_panel = require("layout.date-panel")

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function (s)
    s.workspace_panel = workspace_panel(s, true)
    s.systemtray_panel = systemtray_panel(s, true)
    s.clock_panel = clock_panel(s, true)
    s.date_panel = date_panel(s, true)
end)

-- Hide bars when app go fullscreen
local updateBarsVisibility = function ()
    for s in _G.screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreenMode
            s.workspace_panel.visible = not fullscreen
            s.systemtray_panel.visible = not fullscreen
            s.clock_panel.visible = not fullscreen
            s.date_panel.visible = not fullscreen
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