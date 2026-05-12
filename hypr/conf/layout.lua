hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 8,
        border_size = 1,
        layout = "scrolling",
        resize_on_border = true,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    scrolling = {
        column_width = 0.5,
        focus_fit_method = 0,
        direction = "right",
        fullscreen_on_one_column = true,
    },

    gestures = {
        workspace_swipe_distance = 300,
        workspace_swipe_invert = true,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_create_new = true,
        workspace_swipe_forever = false,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        close_max_timeout = 1000,
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
})

hl.config({
    master = {
        -- Kept empty intentionally: the old config only had a commented setting.
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "up", action = "special", workspace_name = "magic" })
hl.gesture({ fingers = 4, direction = "down", action = "float" })
hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
