class_name WindowManager
extends Node

var window : Window ## Which window this manager's managin'.
var position : Vector2 : get = _get_position, set = _set_position ## The position of the window.
var size : Vector2 ## The size of the window.
var screen : int ## Which screen the window belongs to.

func _init(window: Window) -> void:
	self.window = window

#region // 󰍺 MONITORS.

# What TODO:
	# Get monitor from position.
	# Get monitor names.

## Get id of window. Returns -1 if no window.
func get_id() -> int:
	if not window:
		return -1
	
	return window.get_window_id()

## Gets id on monitor window is in.
func get_monitor() -> int:
	return DisplayServer.get_screen_from_rect(Rect2(window.position, window.size))

## If window is within the bounds of monitors.
func in_bounds() -> bool:
	var screen_position : Vector2i
	var screen_size : Vector2i
	
	# TODO : loop through all monitors and see if window is in any, then return true.
	for i: int in DisplayServer.get_screen_count():
		screen_position = DisplayServer.screen_get_position(i)
		screen_size = DisplayServer.screen_get_size(i)
		
		# TODO doesnt work because window wouldn't be able to traverse seams between monitors.
		#    : build virtual environment, test if boxes are within bounds.
	
	return false

#endregion 󰍺 MONITORS.

#region // 󰁌 POSITION & SIZE.

## Saves position to a file.
func save_position() -> void:
	if not name:
		return # TODO : Return a log.
	
	# TODO

## Load position from file, if available.
func load_position() -> void:
	if not name:
		return # TODO : Return a log.
	
	# TODO

## Get position of window.
func _get_position() -> Vector2:
	return window.position

## Get size of window.
func _get_size() -> Vector2:
	return window.size

## Set position of window.
func _set_position(value: Vector2) -> void:
	window.position = value

## Set size of window.
func _set_size(value: Vector2) -> void:
	window.size = size

#endregion 󰁌 POSITION & SIZE.

#region // 󰈔 FILE.

func get_file() -> void:
	if not name:
		return # TODO : Return a log.
	
	# TODO

#endregion 󰈔 FILE.
