extends Node



func _ready() -> void:
	InputSystem.upon_external_keypress.connect(_upon_global_keypress)
	pass


func _upon_global_keypress(keypress: Keypress) -> void:
	print(keypress)
