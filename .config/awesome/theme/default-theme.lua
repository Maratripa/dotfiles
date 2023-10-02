local filesystem = require('gears.filesystem')
local catppuccin = require('theme.catppuccin')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}

theme.icons = theme_dir .. "/icons/"
theme.font = "Iosevka Regular 12"

theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/wallhaven-rddgwm_1920x1080.png"

local colors = catppuccin
theme.colors = colors

local awesome_overrides = function(this)
    this.dir = os.getenv("HOME") .. "/.config/awesome/theme"

    this.pfp = this.dir .. "/pfp.jpg"

    this.icons = this.dir .. "/icons/"
    this.font = "Iosevka Regular 12"
    this.font_name = "Iosevka Regular"
    this.title_font = "Iosevka Regular 14"

    this.fg_normal = "#ffffffde"

    this.fg_focus = colors.fg_normal
    this.fg_urgent = colors.color1
    this.bat_fg_critical = "#232323"

    this.bg_normal = colors.bg_normal
    this.bg_focus = colors.color0
    this.bg_urgent = colors.color8
    this.bg_systray = colors.bg_normal

    -- Borders
    this.border_width = dpi(1)
    this.border_normal = this.bg_normal
    this.border_focus = colors.purple
    this.border_marked = colors.black
    this.useless_gap = dpi(5)
    this.border_radius = dpi(15)

    -- Menu
    this.menu_height = dpi(16)
    this.menu_width = dpi(160)

    -- Tooltips
    this.tooltip_bg = "#232323"
    this.tooltip_border_width = 0
    this.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- Layout
    -- theme.layout_tile = theme.icons .. "layouts/view-quilt.png"

    -- Taglist
    this.taglist_bg = this.bg_normal
    -- theme.taglist_bg_occupied = theme.bg.base
    this.taglist_bg_urgent = this.taglist_bg
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
    this.normal_tag_format = this.icons .. "taglist/circle.svg"
    this.occupied_tag_format = this.normal_tag_format
    this.selected_tag_format = this.icons .. "taglist/hexagon.svg"

    -- Taglist foreground
    this.taglist_fg_focus = colors.green
    this.taglist_fg = colors.black_alt
    this.taglist_fg_occupied = colors.fg_normal

    -- Tasklist
    this.tasklist_font = "Iosevka Regular 12"
    this.tasklist_bg_normal = this.bg_normal
    -- theme.tasklist_bg_focus =
    --     "linear:0,0:0," .. dpi(32) .. ":0," ..
    --     theme.bg.base .. ":1," ..
    --     theme.bg.base .. ":1," ..
    --     theme.fg_normal .. ":1," ..
    --     theme.fg_normal
    -- theme.tasklist_bg_urgent = theme.bg.crust
    -- theme.tasklist_fg_focus = theme.fg_focus
    -- theme.tasklist_fg_urgent = theme.fg_urgent
    -- theme.tasklist_fg_normal = theme.fg_normal

    -- Systray
    this.systray_icon_spacing = dpi(6)

    -- Notifications
    this.notification_icon_size = 16
    this.notification_border_width = 1

    -- Bar
    this.bar_height = dpi(60)
end

return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
