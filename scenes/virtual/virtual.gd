extends Node2D
#
#
#
#var _temp_position : Vector2 ## Temporary position used for calculations.
#var _temp_size : Vector2 ## Temporary size used for calculations.
#
#func _ready() -> void:
	#update_all()
	#save_screen_state()
#
	## if has previous screen state.
	#if FileAccess.file_exists(SCREEN_STATE_FILE_PATH):
		#print(get_screen_state())
		#print(screens)
		#if get_screen_state() == screens:
			#print("yup")
		## TODO : check if 
		#pass
#
## TODO:
##     position monitor shapes.
##     extend edges out until they touch the edge of the total space.
##     if any collision shapes collide with monitor, resize collision to edge of monitor.
##       if collision shape's width or height ~= 0, remove it.
##     remove any duplicate collision shapes.
#
### Save dimensions of all screens and bounding box.
#func save_screen_state() -> void:
	##if FileAccess.file_exists(SCREEN_DIMENSIONS_FILE_PATH):
	#var temp_screens : Array = []
	#var file = FileAccess.open(SCREEN_STATE_FILE_PATH, FileAccess.WRITE)
	#for i: int in screens.size():
		#temp_screens.push_back({
			#x = screens[i].position.x,
			#y = screens[i].position.y,
			#width  = screens[i].size.x,
			#height = screens[i].size.y,
		#})
	#file.store_string(JSON.stringify(temp_screens))
	#file.close()
#
#func get_screen_state() -> Array[Rect2i]:
	#if not FileAccess.file_exists(SCREEN_STATE_FILE_PATH):
		#return []
#
	#var file : FileAccess = FileAccess.open(SCREEN_STATE_FILE_PATH, FileAccess.READ)
	#var temp_screens : Array[Rect2i] = []
	#for rect in JSON.parse_string(file.get_as_text()):
		#temp_screens.push_back(Rect2i(rect.x, rect.y, rect.width, rect.height))
	#return temp_screens
#
#
#func update_all() -> void:
	#update_screens()
	#update_colliders()
	#update_windows()
#
### Updates monitor count, position, size.
#func update_screens() -> void:
	## ensure an equal amount of nodes under screens node.
	#var screen_diff : int = screens.size() - DisplayServer.get_screen_count()
#
	#for i: int in abs(screen_diff): # never enters loop when 0.
		## add screens.
		#if screen_diff < 0:
			#screens.push_back(Rect2i())
			#continue
#
		## remove screens.
		#screens.remove_at(screens.size() - 1)
#
	## TODO : loop through screens and update position and sizes.
	#for i: int in screens.size():
		#screens[i].position = DisplayServer.screen_get_position(i)
		#screens[i].size = DisplayServer.screen_get_size(i)
#
#func update_colliders() -> void:
	## TODO:
	##     extend edges out until they touch the edge of the total space.
	##     if any collision shapes collide with monitor, resize collision to edge of monitor.
	##     check if colliding with any more screens, repeat.
	##       if collision shape's width or height ~= 0, remove it.
	##     remove any duplicate collision shapes.
#
	#pass
#
#func update_windows() -> void:
	#pass
#
### Gets the rectangle that encloses all the screens at once.
#func get_bounds() -> Rect2i:
	#_temp_size = Vector2.ZERO
#
	#for screen in screens:
		#_temp_position = screen.position + screen.size
		#_temp_size.x = max(_temp_position.x, _temp_size.x)
		#_temp_size.y = max(_temp_position.y, _temp_size.y)
#
	#return Rect2i(Vector2i.ZERO, _temp_size)
#
### If given space is within the bounds.[br]
### The bounds is the rectangle that encloses all the screens at once.
#
#
