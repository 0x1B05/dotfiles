local mainMod = "SUPER"

local function bind(keys, dispatcher, opts)
    hl.bind(keys, dispatcher, opts)
end

-- Applications
bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("foot"))
bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))

-- Windows
bind(mainMod .. " + Q", hl.dsp.window.close())
bind(mainMod .. " + F", hl.dsp.window.fullscreen())
bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + BACKSLASH", hl.dsp.layout("togglesplit"))

bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
bind(mainMod .. " + period", hl.dsp.layout("move +col"))
bind(mainMod .. " + comma", hl.dsp.layout("move -col"))

bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
bind(mainMod .. " + SHIFT + I", hl.dsp.layout("colresize +conf"))
bind(mainMod .. " + SHIFT + O", hl.dsp.layout("colresize -conf"))

bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))
bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
bind(mainMod .. " + CTRL + I", hl.dsp.layout("swapcol l"))
bind(mainMod .. " + CTRL + O", hl.dsp.layout("swapcol r"))

bind(mainMod .. " + CTRL + A", hl.dsp.layout("fit tobeg"))
bind(mainMod .. " + CTRL + E", hl.dsp.layout("fit toend"))
bind(mainMod .. " + CTRL + F", hl.dsp.layout("fit active"))
bind(mainMod .. " + CTRL + V", hl.dsp.layout("fit visible"))

bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

bind(mainMod .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))
bind(mainMod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("magic"))

bind(mainMod .. " + G", hl.dsp.group.toggle())
bind(mainMod .. " + Tab", hl.dsp.group.next())
bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.prev())

-- Actions
bind(mainMod .. " + A", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/screenshot.sh"))
bind(mainMod .. " + V", hl.dsp.exec_cmd("~/dotfiles/scripts/cliphist.sh"))

bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/dotfiles/waybar/launch.sh"))
bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/wallpaper.sh"))
bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/wallpaper.sh select"))
bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("wlogout"))
bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("rofi -show drun -replace -i"))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

bind(mainMod .. " + SHIFT + comma", hl.dsp.workspace.move({ monitor = "l" }))
bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = "r" }))

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Fn keys
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"))
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
bind("XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock"))

-- Passthrough SUPER KEY to Virtual Machine
bind(mainMod .. " + P", hl.dsp.submap("passthru"))
hl.define_submap("passthru", "reset", function()
    bind("SUPER + Escape", hl.dsp.submap("reset"))
end)
