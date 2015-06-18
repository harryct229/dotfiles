local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local beautiful = require("beautiful")

configpath = "/home/"..os.getenv("USER").."/.config/awesome/"
beautiful.init(configpath .. "/themes/" .. "green" ..  "/theme.lua")

-- Wibox
ttopwibox  = {}
tbotwibox  = {}
tlayoutbox = {}
tpromptbox = {}

-- Widget Definition
tsystray = wibox.widget.systray()

-- mpdicon = wibox.widget.imagebox()
-- mpdicon:set_image(beautiful.widget_mpd)
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
function (widget, args)
  openTag = "<span color='white'> "
  closeTag = " </span>"
  if args["{state}"] == "Stop" then
    return openTag.."None Playing"..closeTag
  else
    return openTag..args["{Artist}"]..' - '.. args["{Title}"]..closeTag
  end
end
, 10)
-- Background for mpdwidget
mpdbackground = wibox.widget.background()
mpdbackground:set_bg("#5752D5")
mpdbackground:set_widget(mpdwidget)

archicon = wibox.widget.imagebox()
archicon:set_image(beautiful.widget_awesome)
archicon:buttons(awful.button({ }, 1, function ()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({
      bg_normal = beautiful.bg_normal,
      bg_focus  = beautiful.bg_normal,
      border_width = 0,
      width = 300
    })
  end
end))

clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "<span color='white'> %a, %Y.%m.%d - %H: %M </span>", 60)
-- Background for datewidget
datebackground = wibox.widget.background()
datebackground:set_bg("#964712")
datebackground:set_widget(datewidget)


baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_bat)
batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "$2%", 60, "BAT0")

tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
tempwidget = wibox.widget.textbox()
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 9, "thermal_zone0")

cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu,
function(widget, args)
  return string.format("%3d%% %3d%%", args[2], args[3])
end, 3)

memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, " $2M", 6)
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
-- membar:set_vertical(false)
membar:set_background_color("#434343")
membar:set_color(beautiful.fg_normal)
membar:set_border_color(nil)
membar_margin = wibox.layout.margin(membar, 0, 0, 6, 6)
vicious.register(membar, vicious.widgets.mem, "$1", 6)

separator = wibox.widget.textbox()
separator:set_text(' ')

separator2 = wibox.widget.background()
-- separator2:set_text(' ')

-- Taglist
ttaglist = {}
ttaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev))

-- Tasklist
ttasklist = {}
ttasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
  if c == client.focus then
    c.minimized = true
  else
    if not c:isvisible() then
      awful.tag.viewonly(c:tags()[1])
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
  end
end),
awful.button({ }, 3, function ()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({ width=250 })
  end
end),
awful.button({ }, 4, function ()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end))




-- Widget Drawing
for s = 1, screen.count() do
  tpromptbox[s] = awful.widget.prompt()
  ttaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, ttaglist.buttons)
  ttasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, ttasklist.buttons)


  -- Draw the Layoutbox
  tlayoutbox[s] = awful.widget.layoutbox(s)
  tlayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

  ttopwibox[s] = awful.wibox({
    position = "top",
    screen   = s,
    height   = beautiful.bar_height
  })

  local left_top_layout = wibox.layout.fixed.horizontal()
  left_top_layout:add(archicon)
  left_top_layout:add(ttaglist[s])
  left_top_layout:add(separator)
  left_top_layout:add(tpromptbox[s])

  local top_layout = wibox.layout.align.horizontal()
  top_layout:set_left(left_top_layout)
  top_layout:set_middle(ttasklist[s])
  top_layout:set_right(tlayoutbox[s])

  ttopwibox[s]:set_widget(top_layout)

  tbotwibox[s] = awful.wibox({
    position = "bottom",
    screen   = s,
    height   = beautiful.bar_height
  })

  local left_bottom_layout = wibox.layout.fixed.horizontal()
  left_bottom_layout:add(cpuicon)
  left_bottom_layout:add(cpuwidget)
  left_bottom_layout:add(separator)
  left_bottom_layout:add(memicon)
  -- left_bottom_layout:add(membar)
  left_bottom_layout:add(membar_margin)
  left_bottom_layout:add(memwidget)
  left_bottom_layout:add(separator)
  left_bottom_layout:add(tempicon)
  left_bottom_layout:add(tempwidget)
  left_bottom_layout:add(separator)

  -- local middle_bottom_layout = wibox.layout.fixed.horizontal()
  -- middle_bottom_layout:add(separator2)
  -- middle_bottom_layout:fill_space(true)

  local right_bottom_layout = wibox.layout.fixed.horizontal()

  if screen.count() > 1 then
    if s == 2 then
      right_bottom_layout:add(tsystray)
    end
  else
    right_bottom_layout:add(tsystray)
  end
  right_bottom_layout:add(separator)
  -- right_bottom_layout:add(mpdwidget)
  right_bottom_layout:add(baticon)
  right_bottom_layout:add(batwidget)
  right_bottom_layout:add(separator)
  right_bottom_layout:add(mpdbackground)
  -- right_bottom_layout:add(separator)
  -- right_bottom_layout:add(clockicon)
  right_bottom_layout:add(datebackground)

  local bottom_layout = wibox.layout.align.horizontal()
  bottom_layout:set_left(left_bottom_layout)
  -- bottom_layout:set_middle(middle_bottom_layout)
  bottom_layout:set_right(right_bottom_layout)

  tbotwibox[s]:set_widget(bottom_layout)
end
