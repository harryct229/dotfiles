-- AWESOME CONFIG
-- Author: Tomas Pruzina (tomas.pruzina@gmail.com)
-- Description: Awesome config, tested on Gentoo's awesome 3.5.1

-- Standard awesome library
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
ror = require("ror")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- EXTENSIONS (functions etc)
-- local mykb  = require("myrc.kb_layout") -- change keyboard layout
local myro  = require("myrc.run_once")  -- run app as long it's not running already
local myerr = require("myrc.error")     -- error reporting

-- VARIABLES
-- All Settings and Variable goes Here
terminal   = "gnome-terminal"
browser    = "google-chrome"
editor     = "sublime"
fileman    = "nautilus --no-desktop"
editor_cmd = terminal .. " -e " .. editor
configpath = "/home/"..os.getenv("USER").."/.config/awesome/"
suspend_cmd = "/home/"..os.getenv("USER").."/.config/awesome/suspend.sh"
search_tool = "gnome-do"

-- THEME
-- default theme
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
-- beautiful.init(awful.util.getdir("config") .. "/themes/green/theme.lua")

-- CUSTOM THEMES - pick name from themes/
local theme = "green"
beautiful.init(configpath .. "/themes/" .. theme ..  "/theme.lua")

-- Default modkey (DEFAULT Mod4 = WinKey)
modkey = "Mod4"

-- TAGS (screens) && LAYOUTS
require("settings.tags")

-- MENUS (menubar, etc)
require("settings.menus")

-- Default wibox stuff (gentoo config)
require("stock.wiboxrc")

-- Key && mouse bindings
-- require("stock.binds")
require("settings.custom_binds")
root.keys(globalkeys) -- this actually sets the keys

-- WINDOW RULES
-- rules per app (placement, floating, etc)
require("settings.window_rules")

-- SIGNALs function to execute when a new client appears.
require("stock.signals")

-- STARTUP apps
require("settings.startup")

-------------------------------- PLUGIN SECTION ------------------------

--Logger
--dependencies: http://awesome.naquadah.org/wiki/Naughty_log_watcher
--local lognotify = require("lognotify")


--Orglendar plugin
-- uncomment and adjust paths to use

--require('plugins.Orglendar.orglendar')
--orglendar.files = { "/home/username/Documents/Notes/work.org",    -- Specify here all files you want to be parsed, separated by comma.
--                     "/home/username/Documents/stuff/home.org" }
--orglendar.register(mytextclock)


-- wallpaper snippet
local mywp = require("settings.wallpaper")

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
