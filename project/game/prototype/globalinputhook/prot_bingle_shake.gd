extends Node2D



var shaker : Shaker = Shaker.new(10.0, 500.0).randomize_noise()



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	shaker.advance(delta)
	$Sprite2D.offset = shaker.offset
