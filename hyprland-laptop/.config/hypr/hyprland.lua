------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
    output = "DP-7",
    mode = "2560x1440@59.95",
    position = "0x0",
    scale = "1",
})
hl.monitor({
    output = "DP-6",
    mode = "2560x1440@59.95",
    position = "2560x0",
    scale = "1",
})
hl.monitor({
    output = "eDP-1",
    mode = "2160x1350@59.74",
    position = "5120x0",
    scale = "1",
})
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
    mirror = "eDP-1",
})
-- hl.monitor({
--     output = "",
--     mode = "preferred",
--     position = "auto",
--     scale = 1,
-- })

hl.bind("switch:on:Lid Switch", function()
    if #hl.get_monitors() > 1 then
        hl.monitor({ output = "eDP-1", disabled = true })
    end
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    hl.monitor({ output = "eDP-1", disabled = false })
end, { locked = true })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "kitty -e yazi"
local menu = "wofi --show drun" -- TODO look at hyprlauncher?

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/bin/pypr --debug /tmp/pypr.log")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wal -R")
    hl.exec_cmd("dunst")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("nextcloud --background") -- TODO: check if this works without the hack from old config
    hl.exec_cmd("wayscriber --daemon --no-tray")
    -- hl.exec_cmd("thunderbird")
    -- hl.exec_cmd("firefox")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        force_split = 2,
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        font_family = "Monaspace Neon",
        splash_font_family = "Monaspace Neon",
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us,de",
        kb_variant = "de_se_fi,nodeadkeys",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",

        repeat_rate = 50,
        repeat_delay = 600,

        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("pypr toggle dropdown_term"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("wofi --show=run"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.workspace_rule({ workspace = "3", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "4", gaps_in = 0, gaps_out = 0 })

hl.workspace_rule({ workspace = "1", monitor = "DP-7" })
hl.workspace_rule({ workspace = "2", monitor = "DP-7" })
hl.workspace_rule({ workspace = "3", monitor = "DP-7" })
hl.workspace_rule({ workspace = "4", monitor = "DP-6" })
hl.workspace_rule({ workspace = "5", monitor = "DP-7" })

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("$HOME/.local/bin/hyprland/passmenu"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(terminal .. " -e yazi"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("pypr toggle dropdown_music"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("pypr toggle dropdown_calc"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("pypr toggle dropdown_notes"))

hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("$HOME/Projects/hyprflow/hyprflow"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("wayscriber --daemon-toggle"))

hl.bind(mainMod .. " + LEFT", hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + DOWN", hl.dsp.exec_cmd("mpc stop"))
hl.bind(mainMod .. " + UP", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + RIGHT", hl.dsp.exec_cmd("mpc next"))

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Images/screenshots"))
-- hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("killall -SIGUSR1 gpu-screen-recorder"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("dunstctl close"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

local function set_gaps(size)
    return function()
        local ws = hl.get_active_workspace()
        if not ws then
            return
        end
        hl.workspace_rule({ workspace = tostring(ws.id), gaps_out = size, gaps_in = size })
    end
end
hl.bind(mainMod .. " + G", set_gaps(0))
hl.bind(mainMod .. " + SHIFT + G", set_gaps(10))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Pyrpland --
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("pypr layout center toggle"))

-- hl.bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("stash"))
-- hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("pypr toggle_special stash"))
hl.bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("stash"))
hl.bind(mainMod .. " + Q", hl.dsp.window.move({ workspace = "special:stash" }))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pypr wall next"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pypr wall clear"))


-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})
