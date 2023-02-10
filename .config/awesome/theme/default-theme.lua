local filesystem = require('gears.filesystem')
local catppuccin = require('theme.catppuccin')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi


local theme = {}

theme.icons = theme_dir .. "/icons/"
theme.font = "Iosevka Regular 12"

theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/wallhaven-rddgwm_1920x1080.png"

theme.colors = catppuccin.colors
theme.fg = catppuccin.fg
theme.bg = catppuccin.bg

local awesome_overrides = function(theme)
    theme.dir = os.getenv("HOME") .. "/.config/awesome/theme"

    theme.pfp = theme.dir .. "/pfp.jpg"

    theme.icons = theme.dir .. "/icons/"
    theme.font = "Iosevka Regular 12"
    theme.font_name = "Iosevka Regular"
    theme.title_font = "Iosevka Regular 14"

    theme.fg_normal = "#ffffffde"

    theme.fg_focus = theme.fg.text
    theme.fg_urgent = theme.colors.red
    theme.bat_fg_critical = "#232323"

    theme.bg_normal = theme.bg.crust
    theme.bg_focus = theme.bg.surface0
    theme.bg_urgent = theme.bg.surface1
    theme.bg_systray = theme.bg.base

    -- Borders
    theme.border_width = dpi(2)
    theme.border_normal = theme.bg.crust
    theme.border_focus = theme.colors.lavender
    theme.border_marked = theme.bg.surface1
    theme.useless_gap = dpi(5)
    theme.border_radius = dpi(15)

    -- Menu
    theme.menu_height = dpi(16)
    theme.menu_width = dpi(160)

    -- Tooltips
    theme.tooltip_bg = "#232323"
    theme.tooltip_border_width = 0
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- Layout
    -- theme.layout_tile = theme.icons .. "layouts/view-quilt.png"

    -- Taglist
    theme.taglist_bg = theme.bg.crust
    -- theme.taglist_bg_occupied = theme.bg.base
    theme.taglist_bg_urgent = theme.taglist_bg
    -- "linear:0,0:0," .. dpi(48) .. ":0," ..
    -- theme.colors.red .. ":0.07," ..
    -- theme.colors.red .. ":0.07," ..
    -- theme.bg.base .. ":1," ..
    -- theme.bg.base
    -- theme.taglist_bg_focus =
    --     "linear:0,0:0," .. dpi(32) .. ":0," ..
    --     theme.bg.base .. ":1," ..
    --     theme.bg.base .. ":1," ..
    --     theme.bg.base .. ":1," ..
    --     theme.colors.lavender

    -- Taglist icons
    theme.normal_tag_format = theme.icons .. "taglist/circle.svg"
    theme.occupied_tag_format = theme.normal_tag_format
    theme.selected_tag_format = theme.icons .. "taglist/hexagon.svg"

    -- Taglist foreground
    theme.taglist_fg_focus = theme.colors.green
    theme.taglist_fg = theme.fg.overlay0
    theme.taglist_fg_occupied = theme.fg.text

    -- Tasklist
    theme.tasklist_font = "Iosevka Regular 12"
    theme.tasklist_bg_normal = theme.bg.crust
    theme.tasklist_bg_focus =
    "linear:0,0:0," .. dpi(32) .. ":0," ..
        theme.bg.base .. ":1," ..
        theme.bg.base .. ":1," ..
        theme.fg_normal .. ":1," ..
        theme.fg_normal
    theme.tasklist_bg_urgent = theme.bg.crust
    theme.tasklist_fg_focus = theme.fg_focus
    theme.tasklist_fg_urgent = theme.fg_urgent
    theme.tasklist_fg_normal = theme.fg_normal

    -- Systray
    theme.systray_icon_spacing = dpi(6)
end

return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
