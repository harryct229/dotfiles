local awful = require("awful")
-- local lfs   = require("lfs")

-- local function processwalker()
--    local function yieldprocess()
--       for dir in lfs.dir("/proc") do
--         if tonumber(dir) ~= nil then
--           local f, err = io.open("/proc/"..dir.."/cmdline")
--           if f then
--             local cmdline = f:read("*all")
--             f:close()
--             if cmdline ~= "" then
--               coroutine.yield(cmdline)
--             end
--           end
--         end
--       end
--     end
--     return coroutine.wrap(yieldprocess)
-- end

function run_once(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then
      findme = cmd:sub(0, firstspace-1)
   end
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
-- run once END
