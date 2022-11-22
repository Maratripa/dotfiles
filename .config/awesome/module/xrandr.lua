local gtable = require("gears.table")
local awful = require("awful")
local naughty = require("naughty")


-- Get active outputs
local outputs = function ()
    local outputs = {}
    local xrandr = io.popen("xrandr -q --current")

    if xrandr then
        for line in xrandr:lines() do
            local output = line:match("^([%w-]+) connected")
            if output then
                outputs[#outputs + 1] = output
            end
        end
        xrandr:close()
    end

    return outputs
end

local menu_primary = function ()
    local out = outputs()
    local menu_primary = {}

    for _, o in ipairs(out) do
        local cmd = "xrandr --output " .. o .. " --primary"
        local label = "Set " .. o .. " primary"

        menu_primary[#menu_primary + 1] = {label, cmd}
    end

    return menu_primary
end

local state = {
    notif = nil
}

local naughty_destroy_callback = function (id)
    local action = state.index and state.action
    if id == state.id then
        if action then
            awful.spawn(action, false)
            state.index = nil
            _G.awesome.restart()
        end
    end
end

local toggle_primary = function ()
    if not state.index then
        state.menu = menu_primary()
        state.index = 1
        state.action = nil
    end

    local label
    local next = state.menu[state.index]
    state.index = state.index + 1

    if not next then
        next = state.menu[1]
        state.index = 2
    end

    label, state.action = next[1], next[2]

    if state.notif then
        state.id = state.id + 1
        state.notif:destroy()
    end

    state.notif = naughty.notification {
        title = label,
        timeout = 3,
        screen = awful.screen.focused()
    }

    state.notif:connect_signal(
        "destroyed",
        function ()
            local id = state.notif._private.id
            naughty_destroy_callback(id)
        end
    )

    state.id = state.notif._private.id
end

return {
    toggle_primary = toggle_primary
}