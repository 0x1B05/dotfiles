hl.window_rule({
    name = "firefox-tile",
    match = { title = "^(firefox)$" },
    tile = true,
})

hl.window_rule({
    name = "nm-connection-editor-float",
    match = { title = "^(nm-connection-editor)$" },
    float = true,
})

hl.window_rule({
    name = "qalculate-gtk-float",
    match = { title = "^(qalculate-gtk)$" },
    float = true,
})

hl.window_rule({
    name = "idle-inhibit-fullscreen",
    match = { fullscreen = true },
    idle_inhibit = "fullscreen",
})

hl.window_rule({
    name = "pavucontrol-float",
    match = { class = "(.*org.pulseaudio.pavucontrol.*)" },
    float = true,
    size = { 800, 600 },
    center = true,
    pin = true,
})

hl.window_rule({
    name = "blueman-manager-float",
    match = { class = "(blueman-manager)" },
    float = true,
    size = { 800, 600 },
    center = true,
})

hl.window_rule({
    name = "feishu-meeting-class-float",
    match = { class = "^(Meeting)$" },
    float = true,
})

hl.window_rule({
    name = "feishu-meeting-title-float",
    match = { title = "^(Feishu Meetings)$" },
    float = true,
})

hl.window_rule({
    name = "vivado-win0-float",
    match = { class = "^(Vivado)$", title = "^(win0)$" },
    float = true,
})

hl.window_rule({
    name = "vivado-main-tile",
    match = { class = "^(Vivado)$", title = "^(Vivado.*)$" },
    tile = true,
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name = "no-gaps-wtv1",
    match = { workspace = "w[tv1]", float = false },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    name = "no-gaps-f1",
    match = { workspace = "f[1]", float = false },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    name = "swayimg-pin",
    match = { class = "^(swayimg_pin)$" },
    float = true,
    pin = true,
    border_size = 0,
    suppress_event = "maximize",
    no_initial_focus = true,
    opacity = "0.9 override 0.9 override",
})
