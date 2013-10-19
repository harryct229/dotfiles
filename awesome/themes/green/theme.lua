
theme = {}
-- theme.wallpaper_cmd = { "awsetbg -a /home/thanh/Pictures/background.jpg" }
theme.wallpaper = "/home/thanh/Pictures/background.jpg"
theme.icon_theme = nil

confdir = awful.util.getdir("config") .. "/themes/green"

theme.font          = "Code Bold 8"

theme.bg_normal     = "#050c12"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = "#e73c1c"
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.menu_normal   = "#050c12"
theme.menu_focus    = "#050c12"

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#6da7d3"
theme.fg_urgent     = "ffffff"
theme.fg_minimize   = theme.fm_focus

theme.border_width  = 2
theme.border_normal = "#000000"
theme.border_focus  = "#7890f0"
theme.border_marked = theme.border_focus


theme.bar_height  = 18
theme.menu_height = 20
theme.menu_width  = 120

-- Icon Settings
theme.widget_awesome = confdir .. "/icons/awesome-icon.png"
theme.widget_mpd = confdir .. "/icons/music.png"
theme.widget_clock = confdir .. "/icons/time.png"
theme.widget_bat = confdir .. "/icons/bat.png"
theme.widget_sep = confdir .. "/icons/seperator.png"
theme.widget_temp = confdir .. "/icons/temp.png"
theme.widget_cpu = confdir .. "/icons/cpu.png"
theme.widget_mem = confdir .. "/icons/mem.png"

theme.layout_tile = confdir .. "/layouts/tile.png"
theme.layout_tileleft = confdir .. "/layouts/tileleft.png"
theme.layout_fairv = confdir .. "/layouts/fairv.png"
theme.layout_max = confdir .. "/layouts/max.png"
theme.layout_floating = confdir .. "/layouts/floating.png"
theme.layout_magnifier = confdir .. "/layouts/magnifier.png"

return theme
