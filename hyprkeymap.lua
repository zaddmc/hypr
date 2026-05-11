-- #################
-- ### VARIABLES ###
-- #################
local terminal = "kitty"
local browser = "zen-browser"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + q", hl.dsp.window.close())
hl.bind("SUPER + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + d", hl.dsp.exec_cmd('notify-send -t 0 "Window Info" "$(hyprctl activewindow)"'))
hl.bind("SUPER + d", hl.dsp.exec_cmd("nc -U /run/user/1000/walker/walker.sock"))
hl.bind("SUPER + o", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tesseract stdin - | wl-copy'))
hl.bind("SUPER + SHIFT + o", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tesseract -l dan stdin - | wl-copy'))
hl.bind("SUPER + i", hl.dsp.exec_cmd("hyprlock"))

-- Reset various things
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("pkill waybar; waybar"))
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("pkill elephant; elephant"))
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("pkill walker; walker --gapplication-service"))

hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprlock"))

-- Windows and Workspaces
for i = 1, 10, 1 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind("SUPER + F2", hl.dsp.focus({ workspace = 12 }))
hl.bind("SUPER + SHIFT + F2", hl.dsp.window.move({ workspace = 12, follow = false }))

hl.bind("SUPER + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- External
hl.bind("SUPER + e", hl.dsp.focus({ workspace = "name:external" }))
hl.bind("SUPER + SHIFT + e", hl.dsp.window.move({ workspace = "name:external", follow = false }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + ALT + mouse:272", hl.dsp.window.resize(), { mouse = true })

for key, value in pairs({ h = "left", l = "right", j = "down", k = "up" }) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = value }))
    hl.bind("SUPER + " .. value, hl.dsp.focus({ direction = value }))

    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = value }))
    hl.bind("SUPER + SHIFT + " .. value, hl.dsp.window.swap({ direction = value }))

    local x = (key == "l" and 10 or key == "h" and -10 or 0)
    local y = (key == "j" and 10 or key == "k" and -10 or 0)
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
    hl.bind("SUPER + ALT + " .. value, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
end

-- Laptop multimedia keys for volume
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    { locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" "$HOME/Screenshots/$(date +%y-%m-%d_%H:%M:%S).png"'))

-- Projection Settings and fucker
hl.bind("SUPER + p", hl.dsp.submap("projection"))
hl.define_submap("projection", function()
    hl.bind("m", hl.dsp.exec_cmd("HDMI-A-1, 1920x1080@30, auto, 1, mirror, eDP-1"))
    hl.bind("m", hl.dsp.submap("reset"))
    hl.bind("s", hl.dsp.exec_cmd("HDMI-A-1, 1920x1080@30, auto, 1"))
    hl.bind("s", hl.dsp.submap("reset"))
    hl.bind(
        "w",
        hl.dsp.exec_cmd('ffplay -nodisp -volume 15 "/home/zadd/Stuff/10 Hours of calming sounds to keep you awake.mp3"')
    )
    hl.bind("w", hl.dsp.submap("reset"))

    hl.bind("catchall", hl.dsp.submap("reset"))
end)
