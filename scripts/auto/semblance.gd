@tool
extends Node

## The first time the game is run ever ever, this is called.
func setup() -> void:
	pass

func _ready() -> void:
	# first-time setup.
	
	
	# both in-editor and in-game.
	pass
	
	# in-editor.
	if Engine.is_editor_hint():
		process = editor_process
		return
	
	# in-game.
	pass

static var editor_process : Callable = func(delta: float) -> void:
	pass

static var process : Callable = func(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	process.call()

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
