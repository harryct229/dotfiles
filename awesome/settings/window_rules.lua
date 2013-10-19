local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
        {
                rule = { class = "Skype" },
                properties = { tag = tags[1][4] }
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


