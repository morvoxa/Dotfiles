-- cpu_temp.lua
-- Simple CPU temperature widget for AwesomeWM

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local cpu_temp = {}

-- ================= CONFIG =================
cpu_temp.font = "JetBrainsMono Nerd Font 8"
cpu_temp.color = "#c9970c"
cpu_temp.update_time = 1 -- seconds
cpu_temp.icon = " "
-- ==========================================

cpu_temp.widget = wibox.widget({
	markup = cpu_temp.icon .. "--°C",
	font = cpu_temp.font,
	widget = wibox.widget.textbox,
	align = "center",
	valign = "center",
})

-- Update temperature
gears.timer({
	timeout = cpu_temp.update_time,
	autostart = true,
	call_now = true,
	callback = function()
		awful.spawn.easy_async_with_shell(
			[[
            sensors | awk '/Package id 0/ {print $4}' | tr -d '+°C'
            ]],
			function(out)
				local temp = tonumber(out)
				if temp then
					cpu_temp.widget.markup = "<span foreground='"
						.. cpu_temp.color
						.. "'>"
						.. cpu_temp.icon
						.. temp
						.. "°C</span>"
				end
			end
		)
	end,
})

return cpu_temp.widget
