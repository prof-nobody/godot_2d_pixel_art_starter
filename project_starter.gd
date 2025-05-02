@tool
extends EditorPlugin
# By NickyBHobbying
# twitch nickybhobbying
# twitter @nickybhobbying
# Version 2
# I have found that I like to start projects and find it tedious to do the same steps
# over and over. So I wrote this script to handle that.
# This tool script allows you to quickly setup a 2d pixel art game with some basic settings. 
# Feel free to modify this in other ways you want to fit your game dev needs.
var screen_resolution: Array[Vector2i] = [Vector2i(320,180), Vector2i(640,360), Vector2i(1280,720), Vector2i(1920,1080)] 
@export_multiline var instructions: String = "The below settings will allow you to customize your experience without having to open the accompanying project_starter.gd.
Display Window Size is for picking your base resolution. Commonly this is 320x180 or 640x360 but I have added in 720 and 1080.
Directories are the common directories I create when starting a project. You can edit the list of directories and even add more if you want.
Scene directories and Script directors are used to create sub directories for organizing your project. You can definitely add more if you so desire
and if you have some better naming conventions let me know. Especially for levels. I keep bouncing between levels, maps, and just calling it scenes. 
But I hate that it would the be scenes/scenes."
@export_enum("320x180", "640x360", "1280x720", "1920x1080") var display_window_size: int ## What is the screen resolution you would like to have your game base be in?
@export var directories: Array = ["art", "audio", "fonts", "resources", "scenes", "scripts"] ## Default directories it will create in the FileSystem
@export var scene_directories: Array = ["levels", "items", "characters", "ui"] ## Sub directories created in the Scenes directory
@export var script_directories: Array = ["autoloads", "items", "characters", "ui"] ## Sub directories created in the Scripts directory


@export_tool_button("Setup Framework") var something_else = setup_framework

# Instructions 
# - Add the file to your project 
# - Open script editor
# - Open setup_framework.gd 
# - Select File -> Run (from inside the Script Editor window)



# Called when the script is executed (using File -> Run in Script Editor).
func setup_framework() -> void:
	print("display window size is: %s" % display_window_size)
	var dir = DirAccess.open("res://")
	# Setting height and width of the window to be a normal size
	ProjectSettings.set_setting("display/window/size/viewport_width", screen_resolution[display_window_size].x)
	ProjectSettings.set_setting("display/window/size/viewport_height", screen_resolution[display_window_size].y)
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
