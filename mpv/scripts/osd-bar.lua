-- 只有这么传输命令，在一直显示osd-bar时才能不对其他lua脚本文字的显示和其他操作时osd文字的显示产生干扰和闪烁
local osd_duration_value = mp.get_property_osd("osd-duration")
local osd_duration_value_second = osd_duration_value / 1000
local osd_bar_value = mp.get_property_osd("osd-bar")
local osd_level_value = mp.get_property_osd("osd-level")

function osdbar_show_hide_with_fullscreen(name, param)
	if param == true then
		-- 使用stop()大部分时间会比kill()更快
		osd_bar_show_forever:stop()
	else
		--这一行是为了退出全屏后立刻显示osd-bar，而不是等待osd_duration_value_second秒后才开始一直显示
		mp.command("osd-bar show-progress")
		osd_bar_show_forever:resume()
	end
end

function file_loaded(event)
	local fullscreen_value = mp.get_property("fullscreen")

	if fullscreen_value == "yes" then
		--如果启动时直接进入全屏，那么不执行快速显示osd bar的命令
	else
		mp.command("osd-bar show-progress")
	end
end

if osd_bar_value ~= "no" and osd_level_value >= "1" then
	--这一行是为了运行后就立刻显示osd-bar，而不是等待osd_duration_value_second秒后才开始一直显示
	--加载文件时
	mp.register_event("file-loaded", file_loaded)

	--mp.add_periodic_timer需要写在最前面，在没有加载这个前调用osd_bar_show_forever:kill()等命令会让mpv崩溃
	osd_bar_show_forever = mp.add_periodic_timer(osd_duration_value_second, function()
		mp.command("osd-bar show-progress")
		--osd_bar_show_forever:resume()
	end)

	--下面一行是当mpv进入全屏状态时加载function，退出全屏状态时加载function
	mp.observe_property("fullscreen", "bool", osdbar_show_hide_with_fullscreen)
end
