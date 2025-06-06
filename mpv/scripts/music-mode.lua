--[[
    A simple script which loads a music profile whenever an audio file is played.
    available at: https://github.com/CogentRedTester/mpv-scripts

	An audio file is a file with audio streams and no video streams above 1 fps
	There is also an option to set an 'undo' profile for when video files are loaded whilst in music mode

	Profiles are only ever applied when switching between audio or video files, so you can change
	settings while listening to a playlist and not have them be reset each track as long as the files are either
	all audio, or all video.

	The script assumes the file will be a video, so the undo profile will not be run on startup.

	The script also adds a few script messages, one to enable/disable/toggle music mode,
	one to lock the script so that it doesn't update automatically, and one to print file metadata to the screen.
	Names and argument options are at the bottom of this script file.
]]
--

local mp = require("mp")
local msg = require("mp.msg")
local opt = require("mp.options")
local utils = require("mp.utils")

--script options, set these in script-opts
local o = {
	--change to disable automatic mode switching
	auto = true,

	--profile to call when valid extension is found
	profile = "music",

	--runs this profile when in music mode and a non-audio file is loaded
	--you should essentially put all your defaults that the music profile changed in here
	undo_profile = "",

	--start playback in music mode. This setting is only applied when the player is initially started,
	--changing this option during runtime does nothing.
	--probably only useful if auto is disabled
	enable = false,

	--the script will also enable the following input section when music mode is enabled
	--see the mpv manual for details on sections
	input_section = "music",

	--dispays the metadata of the track on the osd when music mode is on
	--there is also a script message to enable this seperately
	show_metadata = false,
}

opt.read_options(o, "musicmode", function()
	msg.verbose("options updated")
end)
mp.set_property_bool("user-data/music_mode/active", o.enable)

--a music file is one where mpv returns an audio stream or coverart as the first track
local function is_audio_file()
	local track_list = mp.get_property_native("track-list")

	local has_audio = false
	for _, track in ipairs(track_list) do
		if track.type == "audio" then
			has_audio = true
		elseif not track.albumart and (track["demux-fps"] or 2) > 1 then
			return false
		end
	end
	return has_audio
end

local metadata = mp.create_osd_overlay("ass-events")
metadata.hidden = not o.show_metadata

local function update_metadata()
	metadata.data = mp.get_property_osd("filtered-metadata")
	metadata:update()
end

local function enable_metadata()
	metadata.hidden = false
	metadata:update()
end

local function disable_metadata()
	metadata.hidden = true
	metadata:remove()
end

--changes visibility of metadata
local function show_metadata(command)
	if command == "on" or command == nil then
		enable_metadata()
	elseif command == "off" then
		disable_metadata()
	elseif command == "toggle" then
		if metadata.hidden then
			enable_metadata()
		else
			disable_metadata()
		end
	else
		msg.warn('unknown command "' .. command .. '"')
	end
end

--to prevent superfluous loading of profiles the script keeps track of when music mode is enabled
local musicMode = false

--enables music mode
local function activate()
	if o.profile ~= "" then
		mp.commandv("apply-profile", o.profile)
	end
	mp.commandv("enable-section", o.input_section, "allow-vo-dragging+allow-hide-cursor")
	mp.osd_message("Music Mode enabled")
	mp.set_property_bool("user-data/music_mode/active", true)

	if o.show_metadata then
		show_metadata("on")
	end

	musicMode = true
end

--disables music mode
local function deactivate()
	if o.undo_profile ~= "" then
		mp.commandv("apply-profile", o.undo_profile)
	end
	mp.commandv("disable-section", o.input_section)
	mp.osd_message("Music Mode disabled")
	mp.set_property_bool("user-data/music_mode/active", false)

	if o.show_metadata then
		show_metadata("off")
	end

	musicMode = false
end

local function main()
	--if the file is an audio file then the music profile is loaded
	if is_audio_file() then
		msg.verbose('audio file, applying profile "' .. o.profile .. '"')
		if not musicMode then
			activate()
		end
	elseif o.undo_profile ~= "" and musicMode then
		msg.verbose('video file, applying undo profile "' .. o.undo_profile .. '"')
		deactivate()
	end
end

--sets music mode from script-message
local function script_message(command)
	if command == "on" or command == nil then
		activate()
	elseif command == "off" then
		deactivate()
	elseif command == "toggle" then
		if musicMode then
			deactivate()
		else
			activate()
		end
	else
		msg.warn('unknown command "' .. command .. '"')
	end
end

local function lock()
	o.auto = false
	msg.info("Music Mode locked")
	mp.osd_message("Music Mode locked")
end

local function unLock()
	o.auto = true
	msg.info("Music Mode unlocked")
	mp.osd_message("Music Mode unlocked")
end

--toggles lock
local function lock_script_message(command)
	if command == "on" or command == nil then
		lock()
	elseif command == "off" then
		unLock()
	elseif command == "toggle" then
		if o.auto then
			lock()
		else
			unLock()
		end
	else
		msg.warn('unknown command "' .. command .. '"')
	end
end

--runs when the file is loaded, if script is locked it will do nothing
local function file_loaded()
	if o.auto then
		main()
	end
end

if o.enable then
	activate()
end

--sets music mode
--accepts arguments: 'on', 'off', 'toggle'
mp.register_script_message("music-mode", script_message)

--stops the script from switching modes on file loads
----accepts arguments: 'on', 'off', 'toggle'
mp.register_script_message("music-mode-lock", lock_script_message)

--shows file metadata on osc
--accepts arguments: 'on' 'off' 'toggle'
mp.register_script_message("show-metadata", show_metadata)

mp.add_hook("on_preloaded", 40, file_loaded)
mp.observe_property("filtered-metadata", "string", update_metadata)
