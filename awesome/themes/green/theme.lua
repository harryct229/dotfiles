
theme = {}
-- theme.wallpaper_cmd = { "awsetbg -a /home/thanh/Pictures/background.jpg" }
-- theme.wallpaper_cmd = { "feh --bg-fill /home/framgia/Pictures/background.jpg" }
theme.wallpaper = "/home/framgia/Pictures/background.jpg"

theme.icon_theme = nil

confdir = awful.util.getdir("config") .. "/themes/green"

theme.font          = "KG Cold Coffee 8"

-- theme.bg_normal     = "#050c12"
-- theme.bg_focus      = theme.bg_normal
-- theme.bg_urgent     = theme.bg_normal
-- theme.bg_minimize   = theme.bg_normal
-- theme.bg_systray    = theme.bg_normal

-- theme.menu_normal   = "#050c12"
-- theme.menu_focus    = "#050c12"

-- theme.fg_normal     = "#ffffff"
-- theme.fg_focus      = "#6da7d3"
-- theme.fg_urgent     = "#EC7F36"
-- theme.fg_minimize   = theme.fm_focus

-- theme.border_width  = 2
-- theme.border_normal = "#000000"
-- theme.border_focus  = "#7890f0"
-- theme.border_marked = theme.border_focus
-- theme.menu_bg_normal                = "#000000"
-- theme.menu_bg_focus                 = "#ffffff"
theme.bg_normal                     = "#000000"
theme.bg_focus                      = "#000000"
theme.bg_urgent                     = "#000000"
theme.fg_normal                     = "#aaaaaa"
theme.fg_focus                      = "#ff8c00"
theme.fg_urgent                     = "#E2342E"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#424242"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#aaaaaa"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "1"
theme.border_normal                 = "#1c2022"
theme.border_focus                  = "#964712"
theme.border_marked                 = "#3ca4d8"
theme.menu_border_width             = "3"
theme.menu_fg_normal                = "#aaaaaa"
theme.menu_fg_focus                 = "#050505dd"
theme.menu_bg_normal                = "#050505dd"
theme.menu_bg_focus                 = "#ffffff"


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
