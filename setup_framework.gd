@tool
extends EditorScript
# By NickyBHobbying
# twitch nickybhobbying
# twitter @nickybhobbying

# I have found that I like to start projects and find it tedious to do the same steps
# over and over. So I wrote this script to handle that.
# This tool script allows you to quickly setup a 2d pixel art game with some basic settings. 
# Feel free to modify this in other ways you want to fit your game dev needs.

# Instructions 
# - Add the file to your project 
# - Open script editor
# - Open setup_framework.gd 
# - Select File -> Run (from inside the Script Editor window)

var directories: Array = ["art", "audio", "fonts", "resources", "scenes", "scripts"]
var scene_directories: Array = ["levels", "items", "characters", "ui"]
var script_directories: Array = ["autoloads", "items", "characters", "ui"]


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var dir = DirAccess.open("res://")
	# Setting height and width of the window to be a normal size
	ProjectSettings.set_setting("display/window/size/viewport_width", 1280)
	ProjectSettings.set_setting("display/window/size/viewport_height", 720)
	# changes rendering to nearest for pixel art projects
	ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", 0)
	# set window to viewport stretch mode, keep_width aspect, and integer scale mode
	ProjectSettings.set_setting("display/window/stretch/mode", "viewport")
	ProjectSettings.set_setting("display/window/stretch/aspect", "keep_width")
	ProjectSettings.set_setting("display/window/stretch/scale_mode", "integer")
	ProjectSettings.set_setting("rendering/2d/snap/snap_2d_transforms_to_pixel", true)
	var res
	print("creating the directories")
	for directory in directories:
		res = dir.make_dir(directory)
		
		print("Creating %s and the code is %s" % [directory, res])
		if directory == "scenes":
			var s_dir = DirAccess.open("res://scenes")
			for d in scene_directories:
				s_dir.make_dir(d)
		if directory == "scripts":
			var s_dir = DirAccess.open("res://scripts")
			for d in script_directories:
				s_dir.make_dir(d)
		
	# this triggers a scan of the resources to see if there are new items in there.
	# As we have just created the directories there will be new items to have shown
	EditorInterface.get_resource_filesystem().scan()
