-- Swayimg 5.7 Lua config.
-- Field-style API: swayimg.set_mode()/set_*()/enable_*() were removed or
-- deprecated in 5.5-5.7, use the corresponding fields instead.

local function toggle_text()
  swayimg.text.visible = not swayimg.text.visible
end

local function toggle_fullscreen()
  swayimg.fullscreen = not swayimg.fullscreen
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
  swayimg.viewer.open("next")
end

local function viewer_prev()
  swayimg.viewer.open("prev")
end

local function viewer_next_dir()
  swayimg.viewer.open("next_dir")
end

local function viewer_prev_dir()
  swayimg.viewer.open("prev_dir")
end

local function viewer_random()
  swayimg.viewer.open("random")
end

local function slideshow_next()
  swayimg.slideshow.open("next")
end

local function slideshow_prev()
  swayimg.slideshow.open("prev")
end

local function gallery_thumb(delta)
  swayimg.gallery.thumb_size = math.max(60, swayimg.gallery.thumb_size + delta)
end

local function set_mode(mode)
  return function()
    swayimg.mode = mode
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
swayimg.mode = "viewer"
swayimg.antialiasing = true
swayimg.decoration = false
swayimg.overlay = false
swayimg.exif_orientation = true
swayimg.set_window_size(1280, 720)
swayimg.dnd_button = "MouseRight"

-- Image list
swayimg.imagelist.order = "alpha"
swayimg.imagelist.reverse = false
swayimg.imagelist.recursive = false
swayimg.imagelist.adjacent = false
swayimg.imagelist.fsmon = true

-- Text layer
swayimg.text.visible = true
swayimg.text.font = "monospace"
swayimg.text.size = 14
swayimg.text.padding = 10
swayimg.text.color = 0xffcccccc
swayimg.text.background = 0x00000000
swayimg.text.shadow = 0xd0000000
swayimg.text.timeout = 5
swayimg.text.status_timeout = 3

-- Viewer
swayimg.viewer.default_scale = "optimal"
swayimg.viewer.default_position = "center"
swayimg.viewer.drag_button = "MouseLeft"
swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
swayimg.viewer.autopos = "center"
swayimg.viewer.loop = true
swayimg.viewer.preload = 1
swayimg.viewer.history = 1
swayimg.viewer.mark_color = 0xff808080
swayimg.viewer.pinch_factor = 1.0
swayimg.viewer.text = {
  topleft = {
    "{name}",
    "{format}",
    "{sizehr}",
    "{frame.width}x{frame.height}",
    "{meta.Exif.Image.Model}",
  },
  topright = {
    "{list.index}/{list.total}",
  },
  bottomleft = {
    "{scale}",
    "{frame.index}/{frame.total}",
  },
}

-- Slideshow
swayimg.slideshow.timeout = 3
swayimg.slideshow.default_scale = "fit"
swayimg.slideshow.default_position = "center"
swayimg.slideshow.set_window_background(0xff000000)
swayimg.slideshow.preload = 1
swayimg.slideshow.history = 0
swayimg.slideshow.text = {
  topright = { "{list.index}/{list.total}" },
  bottomright = { "{dir}" },
}

-- Gallery
swayimg.gallery.aspect = "fill"
swayimg.gallery.thumb_size = 200
swayimg.gallery.padding_size = 5
swayimg.gallery.border_size = 5
swayimg.gallery.border_color = 0xff000000
swayimg.gallery.selected_scale = 1.10
swayimg.gallery.selected_color = 0xff404040
swayimg.gallery.unselected_color = 0xff202020
swayimg.gallery.window_color = 0xff000000
swayimg.gallery.pinch_factor = 100.0
swayimg.gallery.cache = 100
swayimg.gallery.preload = false
swayimg.gallery.pstore = false
swayimg.gallery.text = {
  topright = { "{list.index}/{list.total}" },
  bottomright = { "{name}" },
}

-- Viewer keymap
swayimg.viewer.on_key("Escape", swayimg.exit)
swayimg.viewer.on_key("q", swayimg.exit)
swayimg.viewer.on_key("Return", set_mode("gallery"))
swayimg.viewer.on_key("Tab", set_mode("gallery"))
swayimg.viewer.on_key("s", set_mode("slideshow"))
swayimg.viewer.on_key("f", toggle_fullscreen)
swayimg.viewer.on_key("Ctrl-r", swayimg.viewer.reload)
swayimg.viewer.on_key("I", toggle_text)

swayimg.viewer.on_key("g", function() swayimg.viewer.open("first") end)
swayimg.viewer.on_key("Shift-g", function() swayimg.viewer.open("last") end)
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
swayimg.slideshow.on_key("f", toggle_fullscreen)
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
swayimg.gallery.on_key("f", toggle_fullscreen)
swayimg.gallery.on_key("Ctrl-r", function()
  swayimg.mode = "viewer"
  swayimg.viewer.reload()
  swayimg.mode = "gallery"
end)
swayimg.gallery.on_key("I", toggle_text)

swayimg.gallery.on_key("g", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Shift-g", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("Left", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("Right", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("Up", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("Down", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("Next", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Prior", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("Shift-j", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Shift-k", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("i", function() gallery_thumb(20) end)
swayimg.gallery.on_key("o", function() gallery_thumb(-20) end)
swayimg.gallery.on_key("Plus", function() gallery_thumb(20) end)
swayimg.gallery.on_key("Minus", function() gallery_thumb(-20) end)
