-- net_speed.lua
-- Internet Speed Meter for AwesomeWM
-- Auto-detect active network interface
-- Arrow blinks ONLY when downloading
-- Shows "No Internet" if no actual internet connection

local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local net_speed = {}

-- ================= CONFIG =================
net_speed.update_interval = 1     -- detik
net_speed.blink_interval  = 0.5   -- kedip panah
net_speed.font = "JetBrainsMono Nerd Font 8"
net_speed.color = "#ffffff"
net_speed.icon = " "
net_speed.arrow = ""
-- ==========================================

-- Detect default network interface
local function detect_interface(callback)
    awful.spawn.easy_async_with_shell(
        "ip route | awk '/default/ {print $5; exit}'",
        function(stdout)
            local iface = stdout:gsub("%s+", "")
            if iface == "" then iface = "lo" end
            callback(iface)
        end
    )
end

local function read_bytes(path)
    local f = io.open(path)
    if not f then return 0 end
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
        font = net_speed.font,
        align = "center",
        valign = "center",
    })

    local blink_state = false
    local current_speed = "--"
    local downloading = false

    -- Timer untuk kedip panah (hanya saat download)
    gears.timer({
        timeout = net_speed.blink_interval,
        autostart = true,
        callback = function()
            if downloading then
                blink_state = not blink_state
            else
                blink_state = false
            end

            local arrow = blink_state and net_speed.arrow or "  "

            widget.markup = string.format(
                "<span foreground='%s'> %s %s %s </span>",
                net_speed.color,
                net_speed.icon,
                arrow,
                current_speed
            )
        end,
    })

    detect_interface(function(interface)
        local rx_path = "/sys/class/net/" .. interface .. "/statistics/rx_bytes"

        local rx_prev = read_bytes(rx_path)

        gears.timer({
            timeout = net_speed.update_interval,
            autostart = true,
            call_now = true,
            callback = function()
                local rx = read_bytes(rx_path)
                local rx_rate = math.max(0, (rx - rx_prev) / 1024)
                rx_prev = rx

                -- cek koneksi internet nyata
                awful.spawn.easy_async_with_shell(
                    "ping -c 1 -W 1 1.1.1.1 >/dev/null && echo 1 || echo 0",
                    function(stdout)
                        local online = stdout:match("1")
                        if online then
                            -- ada koneksi internet, tampilkan speed
                            current_speed = format_speed(rx_rate)
                            downloading = rx_rate > 0
                        else
                            -- tidak ada koneksi internet
                            current_speed = "No Internet"
                            downloading = false
                        end
                    end
                )
            end,
        })
    end)

    return widget
end

return net_speed
