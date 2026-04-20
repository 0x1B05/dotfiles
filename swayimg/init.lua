-- Swayimg 5.x config.
-- The old INI-style config is ignored by current swayimg releases; this file
-- carries the active keymap and runtime settings.

local function toggle_text()
  if swayimg.text.visible() then
    swayimg.text.hide()
  else
    swayimg.text.show()
  end
end

local function move_view(dx, dy)
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x + dx, pos.y + dy)
end

local function zoom_view(factor)
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale * factor)
end

local function move_view_by_window(x_ratio, y_ratio)
  local wnd = swayimg.get_window_size()
  move_view(math.floor(wnd.width * x_ratio), math.floor(wnd.height * y_ratio))
end

local function viewer_next()
  swayimg.viewer.switch_image("next")
end

local function viewer_prev()
  swayimg.viewer.switch_image("prev")
end

local function viewer_next_dir()
  swayimg.viewer.switch_image("next_dir")
end

local function viewer_prev_dir()
  swayimg.viewer.switch_image("prev_dir")
end

local function viewer_random()
  swayimg.viewer.switch_image("random")
end

local function slideshow_next()
  swayimg.slideshow.switch_image("next")
end

local function slideshow_prev()
  swayimg.slideshow.switch_image("prev")
end

local function gallery_thumb(delta)
  local size = swayimg.gallery.get_thumb_size()
  swayimg.gallery.set_thumb_size(math.max(60, size + delta))
end

local function set_mode(mode)
  return function()
    swayimg.set_mode(mode)
  end
end

local function rotate_viewer(angle)
  return function()
    swayimg.viewer.rotate(angle)
  end
end

local function rotate_slideshow(angle)
  return function()
    swayimg.slideshow.rotate(angle)
  end
end

-- General config
swayimg.set_mode("viewer")
swayimg.enable_antialiasing(true)
swayimg.enable_decoration(false)
swayimg.enable_overlay(false)
swayimg.enable_exif_orientation(true)
swayimg.set_window_size(1280, 720)
swayimg.set_dnd_button("MouseRight")

-- Image list
swayimg.imagelist.set_order("alpha")
swayimg.imagelist.enable_reverse(false)
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(false)
swayimg.imagelist.enable_fsmon(true)

-- Text layer
swayimg.text.set_font("monospace")
swayimg.text.set_size(14)
swayimg.text.set_padding(10)
swayimg.text.set_foreground(0xffcccccc)
swayimg.text.set_background(0x00000000)
swayimg.text.set_shadow(0xd0000000)
swayimg.text.set_timeout(5)
swayimg.text.set_status_timeout(3)

-- Viewer
swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_default_position("center")
swayimg.viewer.set_drag_button("MouseLeft")
swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
swayimg.viewer.enable_centering(true)
swayimg.viewer.enable_loop(true)
swayimg.viewer.limit_preload(1)
swayimg.viewer.limit_history(1)
swayimg.viewer.set_mark_color(0xff808080)
swayimg.viewer.set_pinch_factor(1.0)
swayimg.viewer.set_text("topleft", {
  "{name}",
  "{format}",
  "{sizehr}",
  "{frame.width}x{frame.height}",
  "{meta.Exif.Image.Model}",
})
swayimg.viewer.set_text("topright", {
  "{list.index}/{list.total}",
})
swayimg.viewer.set_text("bottomleft", {
  "{scale}",
  "{frame.index}/{frame.total}",
})

-- Slideshow
swayimg.slideshow.set_timeout(3)
swayimg.slideshow.set_default_scale("fit")
swayimg.slideshow.set_default_position("center")
swayimg.slideshow.set_window_background(0xff000000)
swayimg.slideshow.limit_preload(1)
swayimg.slideshow.limit_history(0)
swayimg.slideshow.set_text("topright", { "{list.index}/{list.total}" })
swayimg.slideshow.set_text("bottomright", { "{dir}" })

-- Gallery
swayimg.gallery.set_aspect("fill")
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.set_padding_size(5)
swayimg.gallery.set_border_size(5)
swayimg.gallery.set_border_color(0xff000000)
swayimg.gallery.set_selected_scale(1.10)
swayimg.gallery.set_selected_color(0xff404040)
swayimg.gallery.set_unselected_color(0xff202020)
swayimg.gallery.set_window_color(0xff000000)
swayimg.gallery.set_pinch_factor(100.0)
swayimg.gallery.limit_cache(100)
swayimg.gallery.enable_preload(false)
swayimg.gallery.enable_pstore(false)
swayimg.gallery.set_text("topright", { "{list.index}/{list.total}" })
swayimg.gallery.set_text("bottomright", { "{name}" })

-- Viewer keymap
swayimg.viewer.on_key("Escape", swayimg.exit)
swayimg.viewer.on_key("q", swayimg.exit)
swayimg.viewer.on_key("Return", set_mode("gallery"))
swayimg.viewer.on_key("Tab", set_mode("gallery"))
swayimg.viewer.on_key("s", set_mode("slideshow"))
swayimg.viewer.on_key("f", function() swayimg.set_fullscreen() end)
swayimg.viewer.on_key("Ctrl-r", swayimg.viewer.reload)
swayimg.viewer.on_key("I", toggle_text)

swayimg.viewer.on_key("g", function() swayimg.viewer.switch_image("first") end)
swayimg.viewer.on_key("Shift-g", function() swayimg.viewer.switch_image("last") end)
swayimg.viewer.on_key("J", viewer_next)
swayimg.viewer.on_key("K", viewer_prev)
swayimg.viewer.on_key("Shift-j", viewer_next)
swayimg.viewer.on_key("Shift-k", viewer_prev)
swayimg.viewer.on_key("Next", viewer_next)
swayimg.viewer.on_key("Prior", viewer_prev)
swayimg.viewer.on_key("Space", viewer_next)
swayimg.viewer.on_key("Shift-u", viewer_prev_dir)
swayimg.viewer.on_key("Shift-d", viewer_next_dir)
swayimg.viewer.on_key("Shift-x", viewer_random)

swayimg.viewer.on_key("h", function() move_view(10, 0) end)
swayimg.viewer.on_key("l", function() move_view(-10, 0) end)
swayimg.viewer.on_key("k", function() move_view(0, 10) end)
swayimg.viewer.on_key("j", function() move_view(0, -10) end)
swayimg.viewer.on_key("Left", function() move_view(10, 0) end)
swayimg.viewer.on_key("Right", function() move_view(-10, 0) end)
swayimg.viewer.on_key("Up", function() move_view(0, 10) end)
swayimg.viewer.on_key("Down", function() move_view(0, -10) end)
swayimg.viewer.on_key("u", function() move_view_by_window(0, 0.10) end)
swayimg.viewer.on_key("d", function() move_view_by_window(0, -0.10) end)
swayimg.viewer.on_key("Shift-h", function() move_view_by_window(0.10, 0) end)
swayimg.viewer.on_key("Shift-l", function() move_view_by_window(-0.10, 0) end)

swayimg.viewer.on_key("i", function() zoom_view(1.10) end)
swayimg.viewer.on_key("o", function() zoom_view(1 / 1.10) end)
swayimg.viewer.on_key("Plus", function() zoom_view(1.10) end)
swayimg.viewer.on_key("Minus", function() zoom_view(1 / 1.10) end)
swayimg.viewer.on_key("Equal", swayimg.viewer.reset)
swayimg.viewer.on_key("z", swayimg.viewer.reset)
swayimg.viewer.on_key("BackSpace", swayimg.viewer.reset)
swayimg.viewer.on_key("w", function() swayimg.viewer.set_fix_scale("width") end)
swayimg.viewer.on_key("Shift-w", function() swayimg.viewer.set_fix_scale("height") end)
swayimg.viewer.on_key("Shift-z", function() swayimg.viewer.set_fix_scale("fill") end)
swayimg.viewer.on_key("e", function() swayimg.viewer.set_fix_scale("real") end)

swayimg.viewer.on_key("r", rotate_viewer(90))
swayimg.viewer.on_key("Shift-r", rotate_viewer(270))
swayimg.viewer.on_key("v", swayimg.viewer.flip_vertical)
swayimg.viewer.on_key("Shift-v", swayimg.viewer.flip_horizontal)

-- Slideshow keymap
swayimg.slideshow.on_key("Escape", swayimg.exit)
swayimg.slideshow.on_key("q", swayimg.exit)
swayimg.slideshow.on_key("Return", set_mode("viewer"))
swayimg.slideshow.on_key("Tab", set_mode("gallery"))
swayimg.slideshow.on_key("s", set_mode("viewer"))
swayimg.slideshow.on_key("f", function() swayimg.set_fullscreen() end)
swayimg.slideshow.on_key("Ctrl-r", swayimg.slideshow.reload)
swayimg.slideshow.on_key("I", toggle_text)
swayimg.slideshow.on_key("J", slideshow_next)
swayimg.slideshow.on_key("K", slideshow_prev)
swayimg.slideshow.on_key("Shift-j", slideshow_next)
swayimg.slideshow.on_key("Shift-k", slideshow_prev)
swayimg.slideshow.on_key("Next", slideshow_next)
swayimg.slideshow.on_key("Prior", slideshow_prev)
swayimg.slideshow.on_key("r", rotate_slideshow(90))
swayimg.slideshow.on_key("Shift-r", rotate_slideshow(270))
swayimg.slideshow.on_key("v", swayimg.slideshow.flip_vertical)
swayimg.slideshow.on_key("Shift-v", swayimg.slideshow.flip_horizontal)

-- Gallery keymap
swayimg.gallery.on_key("Escape", swayimg.exit)
swayimg.gallery.on_key("q", swayimg.exit)
swayimg.gallery.on_key("Return", set_mode("viewer"))
swayimg.gallery.on_key("Tab", set_mode("viewer"))
swayimg.gallery.on_key("s", set_mode("slideshow"))
swayimg.gallery.on_key("f", function() swayimg.set_fullscreen() end)
swayimg.gallery.on_key("Ctrl-r", function()
  swayimg.set_mode("viewer")
  swayimg.viewer.reload()
  swayimg.set_mode("gallery")
end)
swayimg.gallery.on_key("I", toggle_text)

swayimg.gallery.on_key("g", function() swayimg.gallery.switch_image("first") end)
swayimg.gallery.on_key("Shift-g", function() swayimg.gallery.switch_image("last") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_key("Left", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("Right", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("Up", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("Down", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_key("Next", function() swayimg.gallery.switch_image("pgdown") end)
swayimg.gallery.on_key("Prior", function() swayimg.gallery.switch_image("pgup") end)
swayimg.gallery.on_key("Shift-j", function() swayimg.gallery.switch_image("pgdown") end)
swayimg.gallery.on_key("Shift-k", function() swayimg.gallery.switch_image("pgup") end)
swayimg.gallery.on_key("i", function() gallery_thumb(20) end)
swayimg.gallery.on_key("o", function() gallery_thumb(-20) end)
swayimg.gallery.on_key("Plus", function() gallery_thumb(20) end)
swayimg.gallery.on_key("Minus", function() gallery_thumb(-20) end)
