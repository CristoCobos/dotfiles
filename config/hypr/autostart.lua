-- Applications and services started with Hyprland

hl.on("hyprland.start", function()
    -- Status bar
    hl.exec_cmd("waybar")

    -- Notification daemon
    hl.exec_cmd("swaync")

    -- Idle management
    hl.exec_cmd("hypridle")
end)
