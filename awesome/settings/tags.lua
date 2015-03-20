local awful = require("awful")

-- LAYOUTS
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.magnifier,
--    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
--    awful.layout.suit.max.fullscreen,
}

-- TAGS (aka screens)
-- two options, for single or dual display
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
--- }}}

