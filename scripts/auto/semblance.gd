@tool
extends Node

## The first time the game is run ever ever, this is called.
func setup() -> void:
	pass

func _ready() -> void:
	# first-time setup.
	pass
	
	# both in-editor and in-game.
	pass
	
	# in-editor.
	if Engine.is_editor_hint():
		return
	
	# in-game.
	#var bingus : String = "user://test.gd"
	#var script : Node = load(bingus).new()
	#if script:
	#	if script.has_method("doTheTest"):
	#		script.doTheTest()
	update_display_shapes()

func _process(delta: float) -> void:
	# both in-editor and in-game.
	
	# in-editor.
	if Engine.is_editor_hint():
		editor_process(delta)
		return
	
	# in-game
	game_process(delta)

static func editor_process(delta: float) -> void:
	pass

static func game_process(delta: float) -> void:
	pass

#region // 󰍺 MONITORS & WINDOWS.

## Where the screen bounds and dimensions get saved.[br]
## Used when checking if screen stuff has changed since user last opened game.
const SCREEN_STATE_FILE_PATH : String = "user://state/screen.state"

static var display_screen_shapes   : Array[Rect2i] = [] ## Array with all the screen shapes.
static var display_negative_shapes : Array[Rect2i] = [] ## Array with all the negative shapes.
static var display_windows_shapes  : Array[Rect2i] = [] ## Array with all the window shapes.

## Updates screen, negative, and window position/sizes.[br]
## Call at beginning of resize or drag operations. Do not call often.
static func update_display_shapes() -> void:
	update_screen_shapes()
	update_negative_shapes()
	update_window_shapes()

## Update the screen count, sizes, and positions.
static func update_screen_shapes() -> void:
	# ensure an equal amount of nodes under screens node.
	display_screen_shapes = []
	
	for i: int in DisplayServer.get_screen_count():
		display_screen_shapes.push_back(Rect2i())
	
	
	# loop through screens and update position and sizes.
	for i: int in display_screen_shapes.size():
		display_screen_shapes[i].position = DisplayServer.screen_get_position(i)
		display_screen_shapes[i].size = DisplayServer.screen_get_size(i)

## Updates the shapes outside of the screens.
static func update_negative_shapes() -> void:
	display_negative_shapes = []
	
	var virtual_area : Vector2i = get_virtual_area()
	
	# loop through all screen shapes and add edge rectangles.
	for screen: Rect2i in display_screen_shapes:
		# TOP
		display_negative_shapes.push_back(Rect2i(
			screen.position.x, 0,
			screen.size.x, screen.position.y))
		
		# RIGHT
		display_negative_shapes.push_back(Rect2i(
			screen.position.x + screen.size.x, screen.position.y,
			virtual_area.x - (screen.position.x + screen.size.x), screen.size.y))
		
		# BOTTOM
		display_negative_shapes.push_back(Rect2i(
			screen.position.x, screen.position.y + screen.size.y,
			screen.size.x, virtual_area.y - (screen.position.y + screen.size.y)))
		
		# LEFT
		display_negative_shapes.push_back(Rect2i(
			0, screen.position.y,
			screen.position.x, screen.size.y))
	
	var screen : Rect2i
	var n : int # for calculated index of negative for given screen, and for array size for last cull loops.
	var intersection : Rect2i # also used for temp var for negatives in last loop.
	
	# TODO : cut back negatives that are intercepting with other monitors.
	for i: int in display_screen_shapes.size():
		screen = display_screen_shapes[i]
		
		for j: int in display_screen_shapes.size():
			if j == i:
				continue
			
			for k: int in 4:
				n = (i * 4) + k
				intersection = display_screen_shapes[j].intersection(display_negative_shapes[n])
				
				if not intersection:
					continue
				
				match k:
					0: # TOP
						display_negative_shapes[n].position.y = intersection.position.y + intersection.size.y
						display_negative_shapes[n].size.y -= intersection.position.y + intersection.size.y
					1: # RIGHT
						display_negative_shapes[n].size.x = display_negative_shapes[n].position.x - intersection.position.x
					2: # BOTTOM
						display_negative_shapes[n].size.y = display_negative_shapes[n].position.y - intersection.position.y
					3: # LEFT
						display_negative_shapes[n].position.x = intersection.position.x + intersection.size.x
						display_negative_shapes[n].size.x -= intersection.position.x + intersection.size.x
	
	# remove negatives that have no area.
	# loop over negatives backwards so there's no index misplacement errors when deleting items in array.
	n = display_negative_shapes.size()
	for i: int in n:
		# reverse index.
		i = n - i - 1
		intersection = display_negative_shapes[i]
		if intersection.size.x == 0 or intersection.size.y == 0:
			display_negative_shapes.remove_at(i)
			continue
	
	# if negative is smaller than inter.
	n = display_negative_shapes.size()
	for i: int in n:
		# reverse index.
		i = n - i - 1
		for j: int in display_negative_shapes.size():
			if j == i:
				continue
			
			intersection = display_negative_shapes[i].intersection(display_negative_shapes[j])
			
			if not intersection:
				continue
			
			# remove if intersection is equal to current shape.
			if display_negative_shapes[i].intersection(display_negative_shapes[j]) == display_negative_shapes[i]:
				display_negative_shapes.remove_at(i)
				break

static func update_window_shapes() -> void:
	pass

## Get size of virtual area.[br]
## The position of the bottom-right most point of the bottom-right most monitor.
static func get_virtual_area() -> Vector2i:
	var virtual_area = Vector2i.ZERO
	
	for screen: Rect2i in display_screen_shapes:
		virtual_area = Util.vec2i_max(screen.position + screen.size, virtual_area)
	
	return virtual_area

## If given rect is within virtual area.[br]
## See [method get_virtual_area].
func within_virtual_area(rect: Rect2i) -> bool:
	return Rect2i(Vector2i.ZERO, get_virtual_area()).encloses(rect)

#endregion 󰍺 MONITORS & WINDOWS.

#region // 󰫧 VARIABLES.

## Variables to be used in [method format_string].
static var variables : Dictionary = {}

## Replaces text like "{{VARIABLE}}" with their value. Do not call often.
static func format_string(text: String) -> String:
	# don't use static in case of multithreading.
	var format : String = text
	
	for key: String in variables.keys():
		format = format.replace("{{" + key + "}}", str(variables[key]))
	
	return format

## Gets variable that's used in [method format_string].
static func get_variable(name: String) -> Variant:
	return variables[name]

## Sets variable to be included in [method format_string].
static func set_variable(name: String, value: Variant) -> void:
	variables[name] = value

#endregion 󰫧 VARIABLES.
