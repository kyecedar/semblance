extends Node
class_name Keypress

enum Location {
	ETC,
	LEFT,
	RIGHT,
}

var keycode : Key
var location : Location

func _init(event: InputEventKey) -> void:
	var text : String = event.as_text()
	name = text if text == "+" else text.split("+")[-1]
	keycode = event.keycode
	match event.as_text_location():
		"left":
			location = Location.LEFT
		"right":
			location = Location.RIGHT
		_:
			location = Location.ETC
