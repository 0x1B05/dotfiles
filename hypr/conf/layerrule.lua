for _, namespace in ipairs({
    "swaync-control-center",
    "swaync-notification-window",
}) do
    hl.layer_rule({
        name = "swaync-blur-" .. namespace,
        match = { namespace = namespace },
        blur = true,
    })

    hl.layer_rule({
        name = "swaync-ignore-alpha-zero-" .. namespace,
        match = { namespace = namespace },
        ignore_alpha = 0,
    })

    hl.layer_rule({
        name = "swaync-ignore-alpha-half-" .. namespace,
        match = { namespace = namespace },
        ignore_alpha = 0.5,
    })
end
