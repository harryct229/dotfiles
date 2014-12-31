require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require("ror")
local wibox = require("wibox")


beautiful.init(awful.util.getdir("config") .. "/themes/green/theme.lua")

-- Error Handling
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

do
  local in_error = false
  awesome.add_signal("debug::error", function (err)
    if in_error then return end
    in_error = true
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = err
    })
    in_error = false
  end)
end

-- All Settings and Variable goes Here
terminal   = "gnome-terminal"
browser    = "google-chrome"
editor     = "sublime"
fileman    = "nautilus --no-desktop"
findtool   = "synapse"
modkey     = "Mod4"
editor_cmd = terminal .. " -e " .. editor

-- Layout Settings
layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.magnifier,
}

-- Tags
local tags = {}
tags = {
  names = { "home", "code", "www", "comm", "misc" }
}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, {
    layouts[1], -- home
    layouts[1], -- code
    layouts[2], -- www
    layouts[1], -- comm
    layouts[4], -- misc
  })
end

-- Menu
tentry = {
  { "Terminal"     , terminal      } ,
  { "Browser"      , browser       } ,
  { "Editor"       , editor_cmd    } ,
  { "File Manager" , fileman       } ,
  { "Logout"       , awesome.quit  } ,
  { "Suspend"      , "dbus-send --system --print-reply --dest='org.freedesktop.UPower' /org/freedesktop/UPower org.freedesktop.UPower.Suspend" } ,
  { "Hibernate"    , "dbus-send --system --print-reply --dest='org.freedesktop.UPower' /org/freedesktop/UPower org.freedesktop.UPower.Hibernate" } ,
  { "Reboot"       , "dbus-send --system --print-reply --dest='org.freedesktop.ConsoleKit' /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart" } ,
  { "Shut Down"    , "dbus-send --system --print-reply --dest='org.freedesktop.ConsoleKit' /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop" }
}

tmenu = awful.menu.new({
  bg_normal = beautiful.menu_normal,
  bg_focus  = beautiful.menu_focus,
  border_width = 0,
  items = tentry
})

-- Wibox
ttopwibox  = {}
tbotwibox  = {}
tlayoutbox = {}
tpromptbox = {}
tlayoutbox = {}

-- Widget Definition
tsystray = widget({ type = "systray" })

-- mpdicon = widget({ type = "imagebox" })
-- mpdicon.image = image(beautiful.widget_mpd)
mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
function (widget, args)
  openTag = "<span>"
  closeTag = "</span>"
  if args["{state}"] == "Stop" then
    return openTag.."None Playing"..closeTag
  else
    return openTag..args["{Artist}"]..' - '.. args["{Title}"]..closeTag
  end
end
, 10)
-- mpdbackground = wibox.widget.background
-- mpdbackground.set_bg()
-- mpdbackground:set_widget(mpdwidget)

archicon = widget({ type = "imagebox" })
archicon.image = image(beautiful.widget_awesome)
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

clockicon = widget({ type = "imagebox" })
clockicon.image = image(beautiful.widget_clock)
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, " %a, %Y.%m.%d - %H:%M ", 60)

baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$2%", 60, "BAT0")

tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)
tempwidget = widget({ type = "textbox" })
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 9, "thermal_zone0")

cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu,
function(widget, args)
  return string.format("%3d%% %3d%%", args[2], args[3])
end, 3)

memicon = widget ({type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, " $2M", 6)
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
membar:set_vertical(false)
membar:set_background_color("#434343")
membar:set_border_color(nil)
membar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
awful.widget.layout.margins[membar.widget] = { top = 6 }
vicious.register(membar, vicious.widgets.mem, "$1", 6)

separator = widget({ type = "textbox" })
separator.text = '<span color="#9069d0">  </span>'

separator2 = widget({ type = "textbox" })
separator2.text = '<span color="#9069d0">  </span>'

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
  tpromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
  ttaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, ttaglist.buttons)
  ttasklist[s] = awful.widget.tasklist(function(c)
    -- return awful.widget.tasklist.label.currenttags(c, s, { hide_icon = true })
    local t = { awful.widget.tasklist.label.currenttags(c, s) }
    return t[1], t[2], t[3], nil
  end, ttasklist.buttons)

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

  ttopwibox[s].widgets = {
    {
      archicon,
      ttaglist[s],
      separator2,
      tpromptbox[s],
      layout = awful.widget.layout.horizontal.leftright
    },
    tlayoutbox[s],
    ttasklist[s],
    layout = awful.widget.layout.horizontal.rightleft
  }

  tbotwibox[s] = awful.wibox({
    position = "bottom",
    screen   = s,
    height   = beautiful.bar_height
  })

  tbotwibox[s].widgets = {
    {
      -- cpuicon, 
      cpuwidget, separator,
      -- memicon, 
      membar.widget, memwidget, separator,
      -- tempicon, 
      tempwidget, separator,
      layout = awful.widget.layout.horizontal.leftright
    },
    datewidget,
    -- clockicon,
    separator,
    batwidget,
    -- baticon,
    separator,
    mpdwidget,
    -- mpdicon,
    separator,
    tsystray,
    layout = awful.widget.layout.horizontal.rightleft
  }
end

-- Mouse Binding
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function () tmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)))

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Key Binding
tkeys = awful.util.table.join(
  -- Standard
  awful.key({ modkey, }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey, }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore),

  awful.key({ modkey, }, "j", function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey, }, "k", function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey, }, "Tab", function ()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end),

  awful.key({ modkey, }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r",      awesome.restart),
  awful.key({ modkey, "Control" }, "q",      awesome.quit),

  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incnmaster(-1)      end),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

  awful.key({ modkey, "Control" }, "n", awful.client.restore),

  -- My own
  awful.key({ }, "Print", function ()
    awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'")
  end),
  awful.key({ modkey, }, "w", function () tmenu:toggle() end),

  awful.key({ modkey, }, "r", function ()
    awful.prompt.run({ prompt = "Run: " },
    tpromptbox[mouse.screen].widget,
    check_for_terminal, clean_for_completion,
    awful.util.getdir("cache") .. "/history")
  end),
  awful.key({ modkey, }, "x", function ()
    awful.prompt.run({ prompt = "Eval: " },
    tpromptbox[mouse.screen].widget,
    usefuleval,
    nil,
    awful.util.getdir("cache") .. "/history_eval")
  end),

  -- Raise or run
  awful.key({ modkey, "Shift" }, "c", function ()
    ror.run_or_raise(browser, { class = "Google-Chrome" })
  end),
  awful.key({ modkey, "Shift" }, "n", function ()
    ror.run_or_raise(fileman, { class = "Nautilus" })
  end),
  awful.key({ modkey, }, "F2", function ()
    ror.run_or_raise(findtool, { class = "Synapse" })
  end),
  awful.key({ modkey, "Shift" }, "s", function ()
    ror.run_or_raise(editor_cmd, { class = "Sublime_text" })
  end),
  awful.key({ modkey, "Shift" }, "t", function ()
    ror.run_or_raise(terminal, { class = "Gnome-terminal" })
  end)
)

clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                       ),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop           end),
  awful.key({ modkey,           }, "n",      function (c) c.minimized = true              end),
  awful.key({ modkey, "Shift"   }, "x",      function (c) c:kill()                        end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toogle                    ),
  awful.key({ modkey, "Control" }, "Return", function (c) c:wap(awful.client.getmaster()) end),

  awful.key({ modkey, }, "m", function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- Keynumber Binding
keynumber = 0
for s = 1, screen.count() do
  keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
  tkeys = awful.util.table.join(tkeys,
  awful.key({ modkey }, "#" .. i + 9, function ()
    local screen = mouse.screen
    if tags[screen][i] then
      awful.tag.viewonly(tags[screen][i])
    end
  end),
  awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
    if client.focus and tags[client.focus.screen][i] then
      awful.client.movetotag(tags[client.focus.screen][i])
    end
  end))
end

-- Load the Keys
root.keys(tkeys)

-- Rules
awful.rules.rules = {
  {
    rule = { },
    properties = {
      border_width     = beautiful.border_width,
      border_color     = beautiful.border_normal,
      focus            = true,
      keys             = clientkeys,
      buttons          = clientbuttons,
      size_hints_honor = false
    }
  },
  {
    rule = { class = "Audience" },
    properties = { floating = true }
  },
  {
    rule = { class = "Skype" },
    properties = { tag = tags[1][4] }
  },
  {
    rule = { class = "Firefox", name = "Downloads" },
    properties = { floating = true }
  },
  {
    rule = { class = "Plugin-container" }, -- Flash
    properties = { floating = true }
  }
}

-- Naughty
naughty.config.default_preset.width = 360
naughty.config.default_preset.height = nil
naughty.config.default_preset.icon_size = 24

-- Signals
client.add_signal("manage", function (c, startup)
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Functions to help launch run commands in a terminal using ":" keyword
function check_for_terminal (command)
  if command:sub(1,1) == ":" then
    command = terminal .. ' -e "' .. command:sub(2) .. '"'
  end
  awful.util.spawn(command)
end

function clean_for_completion (command, cur_pos, ncomp, shell)
  local term = false
  if command:sub(1,1) == ":" then
    term = true
    command = command:sub(2)
    cur_pos = cur_pos - 1
  end
  command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
  if term == true then
    command = ':' .. command
    cur_pos = cur_pos + 1
  end
  return command, cur_pos
end

-- Eval with result
function usefuleval(s)
  local f, err = loadstring("return "..s)
  if not f then
    f, err = loadstring(s)
  end

  if f then
    setfenv(f, _G)
    local ret = { pcall(f) }
    if ret[1] then
      -- Ok
      table.remove(ret, 1)
      local highest_index = #ret
      for k, v in pairs(ret) do
        if type(k) == "number" and k > highest_index then
          highest_index = k
        end
        ret[k] = select(2, pcall(tostring, ret[k])) or "<no value>"
      end
      -- Fill in the gaps
      for i = 1, highest_index do
        if not ret[i] then
          ret[i] = "nil"
        end
      end

      if highest_index > 0 then
        local ret_txt = tostring(table.concat(ret, ", "))
        naughty.notify({
          title = "Result:",
          text = ret_txt,
          screen = mouse.screen
        })
      else
        naughty.notify({
          title = "Result:",
          text = "Nothing",
          screen = mouse.screen
        })
      end
    else
      err = ret[2]
    end
    if err then
      local err_txt = err
      naughty.notify({
        title = "Error:",
        text = err_txt,
        screen = mouse.screen
      })
    end
  end
end

-- Autostart
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  -- awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
  awful.util.spawn_with_shell("ps aux | grep -v grep | grep " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("gnome-settings-daemon")
run_once("gnome-keyring-daemon --start --components=pkcs11")
run_once("nm-applet")
run_once("dropbox start")
run_once("gnome-do")
-- run_once("jupiter")
-- run_once("mpd")
-- run_once("$HOME/.config/Pow/Current/bin/pow.sh")
-- run_once("xmodmap $HOME/.xmodmap")
-- run_once("$HOME/cli/bin/screens.sh")
