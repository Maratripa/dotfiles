local gtable = require("gears.table")
local default_theme = require("theme.default-theme")

local final_theme = {}
gtable.crush(final_theme, default_theme.theme)
default_theme.awesome_overrides(final_theme)

return final_theme