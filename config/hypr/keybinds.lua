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
