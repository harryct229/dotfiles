require("myrc.run_once")
local awful = require("awful")

--run_once("firefox")
--run_once("pidgin")
--run_once("synclient tapbutton1=1")
--run_once("urxvtd","urxvtd --quiet --opendisplay --fork")

run_once("gnome-settings-daemon")
run_once("gnome-keyring-daemon --start --components=pkcs11")
run_once("gnome-session --session=ubuntu")
run_once("nm-applet")
-- run_once("dropbox start")
-- run_once("skype")
run_once("xautolock -detectsleep -time 10 -locker lock -corners 0-00")
run_once("xautolock -detectsleep -time 60 -locker " .. suspend_cmd)
