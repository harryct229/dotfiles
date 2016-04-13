local awful = require("awful")
local menubar = require("menubar")

-- Mouse Binding
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)))

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- GLOBAL KEYBINDINGS
globalkeys = awful.util.table.join(globalkeys,
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
  awful.key({ modkey, }, "w", function () mymainmenu:toggle() end),

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
  awful.key({ modkey }, "p", function() menubar.show() end),

  -- Raise or run
  awful.key({ modkey, "Shift" }, "c", function ()
    ror.run_or_raise(browser, { class = "Google-Chrome" })
  end),
  awful.key({ modkey, "Shift" }, "n", function ()
    ror.run_or_raise(fileman, { class = "Nautilus" })
  end),
  -- awful.key({ modkey, }, "F2", function ()
  --   ror.run_or_raise(search_tool, { class = "Gnome-Do" })
  -- end),
  awful.key({ modkey, "Shift" }, "s", function ()
    ror.run_or_raise(editor_cmd, { class = "Sublime_text" })
  end),
  awful.key({ modkey, "Shift" }, "t", function ()
    ror.run_or_raise(terminal, { class = "Gnome-terminal" })
  end),
  awful.key({ modkey }, "=", function ()
    awful.util.spawn("amixer -D pulse set Master 10%+")
  end),
  awful.key({ modkey }, "-", function ()
    awful.util.spawn("amixer -D pulse set Master 10%-")
  end),
  awful.key({ modkey, "Shift" }, "-", function ()
    awful.util.spawn("amixer -D pulse set Master toggle")
  end)
)

-- CLIENT KEYS (work on current clients-windows)
clientkeys = awful.util.table.join(clientkeys,
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
  globalkeys = awful.util.table.join(globalkeys,
  awful.key({ modkey }, "#" .. i + 9, function ()
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewonly(tag)
    end
    -- awful.client.focus.filter()
    -- awful.mouse.client.focus:raise()
    -- if client.focus then  end
    -- awful.client.focus.byidx(-1)
    -- if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
    if client.focus and tags[client.focus.screen][i] then
      awful.client.movetotag(tags[client.focus.screen][i])
    end
  end))
end
