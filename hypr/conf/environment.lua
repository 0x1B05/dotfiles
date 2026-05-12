hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("QT_SCALE_FACTOR", "1")
hl.env("XCURSOR_SIZE", "30")
hl.env("GDK_SCALE", "2")

hl.env("ANKI_WAYLAND", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("INPUT_METHOD", "fcitx")

-- Optional profiles kept from the old config:
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("__GL_VRR_ALLOWED", "1")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.config({ cursor = { no_hardware_cursors = true } })
