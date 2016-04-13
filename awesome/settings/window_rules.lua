local awful = require("awful")
local beautiful = require("beautiful")

if screen.count() > 1 then
  main_screen = 2
else
  main_screen = 1
end
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },
        {
                rule = { class = "Skype" },
                properties = { tag = tags[main_screen][4] }
        },
        {
                rule = { instance = "plugin-container" },
                properties = { floating = true }
        },
        {
                rule = { class = "Plugin-container" }, -- Flash
                properties = { floating = true }
        },
}
-- }}}


