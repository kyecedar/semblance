extends Window

var manager : WindowManager

func _ready() -> void:
	manager = WindowManager.new(self)
	
	print(position)
	print(size)
