extends Node



@export var mono : bool = true



func _ready() -> void:
	print()
	print(AudioServer.get_output_device_list())
	print()
	print(AudioServer.get_input_device_list())
	print()


# update ui and other things.
func refresh_audio_device_list() -> void:
	pass
