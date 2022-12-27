local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.autofocus")

local apps = require("configuration.apps")
local xrandr = require("module.xrandr")
local helpers = require("helpers")

local mod = require('configuration.keys.mod').modKey
local shift = "Shift"
local control = "Control"

local globalKeys = gears.table.join(
    -- Hotkeys
    awful.key({mod}, "h", hotkeys_popup.show_help,
        {description = "Show help", group = "awesome"}),
    
    -- Tag browsing
    awful.key({mod}, "Left", awful.tag.viewprev,
        {description = "View previous", group = "tag"}),
    awful.key({mod}, "Right", awful.tag.viewnext,
        {description = "View next", group = "tag"}),
    awful.key({mod}, "Escape", awful.tag.history.restore,
        {description = "Go back", group = "tag"}),
    
    -- Client
    awful.key({mod, shift}, "Right", function () awful.client.focus.byidx(1) end,
        {description = "Focus next by index", group = "client"}),
    awful.key({mod, shift}, "Left", function () awful.client.focus.byidx(-1) end,
        {description = "Focus previous by index", group = "client"}),
    awful.key({ mod, control }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        {description = "Restore minimized", group = "client"}),
    
    -- Layout manipulation
    awful.key({mod}, "Up", function () awful.client.swap.byidx(1) end,
        {description = "Swap with next client by index", group = "client"}),
    awful.key({mod}, "Down", function () awful.client.swap.byidx(-1) end,
        {description = "Swap with previous client by index", group = "client"}),
    
    awful.key({mod, control}, "o", function () awful.screen.focus_relative(1) end,
        {description = "Focus the next screen", group = "client"}),
    
    awful.key({mod}, "Tab",
        function ()
            awful.client.focus.history.previous()
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = "Go back", group = "client"}),

    awful.key({mod, shift}, "space", function () awful.layout.inc(1) end,
        {description = "Select next layout", group = "layout"}),
    
    -- Standard program
    awful.key({mod}, "Return", function () awful.spawn(apps.default.terminal) end,
        {description = "Open a terminal", group = "launcher"}),
    awful.key({mod}, "b", function () awful.spawn(apps.default.browser) end,
        {description = "Open default browser", group = "launcher"}),
    awful.key({mod}, "n", function () awful.spawn(apps.default.files) end,
        {description = "Open default file manager", group = "launcher"}),
    
    -- Quit and reload awesome
    awful.key({mod, control}, "r", _G.awesome.restart,
        {description = "Reload awesome", group = "awesome"}),
    awful.key({mod, control}, "q", _G.awesome.quit,
        {description = "Quit awesome", group = "awesome"}),
    
    -- Menubar TODO
    awful.key({mod}, "d", function () awful.spawn(apps.default.launcher) end,
        {description = "Start launcher", group = "launcher"}),

    -- Xrandr
    awful.key({mod}, "p", xrandr.toggle_primary,
       {description = "Toggle primary monitor", group = "xrandr"}),
    
    -- Keyboard layout
    awful.key({mod}, 'space', function ()
        helpers.toggle_kb_layout()
    end),

    -- Media keys
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end,
        {description="(un)mute volume", group="media"}),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0 && " ..
                "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end,
        {description="Lower volume", group="media"}),
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0 && " ..
                "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end,
        {description="Raise volume", group="media"}),
    
    awful.key({}, "XF86AudioPlay",
        function ()
            awful.spawn.with_shell("playerctl play-pause")
        end,
        {description="Play-pause", group="media"}),
    awful.key({}, "XF86AudioPrev",
        function ()
            awful.spawn.with_shell("playerctl previous")
        end,
        {description="Previous track", group="media"}),
    awful.key({}, "XF86AudioNext",
        function ()
            awful.spawn.with_shell("playerctl next")
        end,
        {description="Next track", group="media"})
)

for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+h)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "View tag #", group = "tag"}
        descr_toggle = {description = "Toggle tag #", group = "tag"}
        descr_move = {description = "Move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end

    globalKeys = gears.table.join(globalKeys,
        -- View tag only
        awful.key({mod}, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view),

        -- Toggle tag display
        awful.key({mod, control}, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle),
        -- Move client to tag and switch to tag
        awful.key({mod, shift}, "#" .. i + 9,
            function ()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            descr_move),
        -- Toggle tag on focused client
        awful.key({mod, control, shift}, "#" .. i + 9,
            function ()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus))
end

return globalKeys
