-- Keyboard shortcuts

-- Main modifier: Super (Windows key)

-- Open terminal
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))

-- Close active window
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())

-- Exit Hyprland
hl.bind("SUPER + SHIFT + M", hl.dsp.exit())

-- Open application launcher
hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun"))

-- Toggle notification center
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client --toggle-panel"))

-- Lock screen
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

-- Volume controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set 5%-"))

-- Scratchpad
-- Move active window to the special workspace
hl.bind("SUPER + H",
        hl.dsp.window.move({ workspace = "special:scratchpad" })
)

-- Toggle scratchpad visibility
hl.bind("SUPER + SHIFT + H",
        hl.dsp.workspace.toggle_special("scratchpad")
)


-- Workspace navigation
-- Switch workspaces with Super + 1-9
-- Move active window with Super + Shift + 1-9

for i = 1, 9 do
        hl.bind("SUPER + " .. i,
                hl.dsp.focus({ workspace = i })
        )

        hl.bind("SUPER + SHIFT + " .. i,
                hl.dsp.window.move({ workspace = i })
        )
end
