local awful = require("awful")
local apps = require("configuration.apps")

local run_once = function (cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || %s", findme, cmd))
end

for _, app in ipairs(apps.run_on_start_up) do
    run_once(app)
end