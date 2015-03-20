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
  { "Suspend"      , suspend_cmd   } ,
  { "Hibernate"    , "dbus-send --system --print-reply --dest='org.freedesktop.login1' /org/freedesktop/login1 org.freedesktop.login1.Manager.Hibernate boolean:true" } ,
  { "Reboot"       , "dbus-send --system --print-reply --dest='org.freedesktop.login1' /org/freedesktop/login1 org.freedesktop.login1.Manager.Reboot boolean:true" } ,
  { "Shut Down"    , "dbus-send --system --print-reply --dest='org.freedesktop.login1' /org/freedesktop/login1 org.freedesktop.login1.Manager.PowerOff boolean:true" }
}

mymainmenu = awful.menu({
  bg_normal = beautiful.menu_normal,
  bg_focus  = beautiful.menu_focus,
  border_width = 0,
  items = tentry
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it