-- net_speed.lua
-- Internet Speed Meter for AwesomeWM
-- Auto-detect active network interface

local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local net_speed = {}

-- ================= CONFIG =================
net_speed.update_interval = 1 -- detik
net_speed.font = "JetBrainsMono Nerd Font 9" -- ubah angka untuk ukuran
net_speed.color = "#00ff00" -- warna teks
net_speed.icon = " " -- icon jaringan
-- ==========================================

-- Detect default network interface
local function detect_interface(callback)
	awful.spawn.easy_async_with_shell("ip route | awk '/default/ {print $5; exit}'", function(stdout)
		local iface = stdout:gsub("%s+", "")
		if iface == "" then
			iface = "lo"
		end
		callback(iface)
	end)
end

local function read_bytes(path)
	local f = io.open(path)
	if not f then
		return 0
	end
	local v = tonumber(f:read("*all")) or 0
	f:close()
	return v
end

local function format_speed(kb)
	if kb > 1024 then
		return string.format("%.2f MB/s", kb / 1024)
	else
		return string.format("%.1f KB/s", kb)
	end
end

function net_speed.new()
	local widget = wibox.widget({
		widget = wibox.widget.textbox,
		text = net_speed.icon .. "--",
		font = net_speed.font,
		align = "center",
		valign = "center",
	})

	detect_interface(function(interface)
		local rx_path = "/sys/class/net/" .. interface .. "/statistics/rx_bytes"
		local tx_path = "/sys/class/net/" .. interface .. "/statistics/tx_bytes"

		local rx_prev = read_bytes(rx_path)
		local tx_prev = read_bytes(tx_path)

		gears.timer({
			timeout = net_speed.update_interval,
			autostart = true,
			call_now = true,
			callback = function()
				local rx = read_bytes(rx_path)
				local tx = read_bytes(tx_path)

				local rx_rate = (rx - rx_prev) / 1024
				local tx_rate = (tx - tx_prev) / 1024

				rx_prev = rx
				tx_prev = tx

				widget.markup = string.format(
					"<span foreground='%s'>  %s ⇅ %s </span>",
					net_speed.color,
					net_speed.icon,
					format_speed(rx_rate)
				)
			end,
		})
	end)

	return widget
end

return net_speed
