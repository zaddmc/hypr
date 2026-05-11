-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################
hl.env("XCURSOR_SIZE", "2")
hl.env("HYPRCURSOR_SIZE", "2")

-- #################
-- ### AUTOSTART ###
-- #################
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock --no-fade-in -c ~/.config/hypr/hyprlock_greet.conf")
    hl.exec_cmd("waybar")
    hl.exec_cmd("walker --gapplication-service")
end)

-- Load the Keymap
require("hyprkeymap")

-- ################
-- ### MONITORS ###
-- ################
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = "1" })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@30", position = "auto", scale = "auto", mirror = "eDP-1" })

-- #############
-- ### INPUT ###
-- #############
hl.config({
    input = {
        kb_layout = "dk",
        kb_options = "caps:escape",
        numlock_by_default = true,
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = false,
        },
    },
})

-- #####################
-- ### LOOK AND FEEL ###
-- #####################
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = { active_border = "rgba(33ccffee)", inactive_border = "rgba(595959aa)" },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false },
        blur = { enabled = false },
    },
    animations = { enabled = false },
})

hl.config({
    dwindle = {
        --pseudotile = true,
        preserve_split = true,
        force_split = 2,
    },
})

-- ############
-- ### MISC ###
-- ############
--hl.config({ misc = {} })

-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$", -- Make it negate maple at some point
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

--hl.workspace_rule({})
for _, key in pairs({ "w[tv1]", "f[1]" }) do
    hl.workspace_rule({ workspace = key, gaps_out = 0, gaps_in = 0 })
    hl.window_rule({ border_size = 0, match = { workspace = key } })
end

hl.window_rule({ name = "special-window-color", match = { workspace = "s[1]" }, border_color = "rgba(FF00BFFF)" })

hl.workspace_rule({ workspace = "1", on_created_empty = "[tile] zen-browser" })

hl.window_rule({
    name = "external-window-color",
    match = { workspace = "name:external" },
    border_color = "rgba(FF00BFFF)",
})
hl.workspace_rule({ workspace = "name:external", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({
    workspace = "name:external",
    on_created_empty = "[tile] /usr/bin/chromium --profile-directory=Default --app-id=cinhimbnkkaeohfgghhklpknlkffjgod ",
})
