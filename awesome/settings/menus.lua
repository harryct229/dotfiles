local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Create a laucher widget and a main menu
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

mymainmenu = awful.menu({
  bg_normal = beautiful.menu_normal,
  bg_focus  = beautiful.menu_focus,
  border_width = 0,
  items = tentry
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it