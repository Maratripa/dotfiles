local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

-- Theme
beautiful.init(require("theme"))

-- Layout
require("ui")

-- Init all modules
require("module.set-wallpaper")
require("module.auto-start")

-- Setup all configurations
require("configuration.notifications")
require("configuration.client")
require("configuration.tags")

-- Init notifications
require("notifications")

_G.root.keys(require("configuration.keys.global"))
