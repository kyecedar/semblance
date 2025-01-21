extends Node
class_name Floater



#region // Variables.

var horizontal      : float = 0.0 :
	set(value):
		horizontal = fmod(value, PI)

var vertical        : float = 0.0 :
	set(value):
		vertical = fmod(value, PI)

var speed     : Vector2 = Vector2(5.0, 5.0)
var amplitude : Vector2 = Vector2(10.0, 10.0)

var offset : Vector2 :
	get():
		return Vector2(cos(horizontal) * amplitude.x, sin(vertical) * amplitude.y)

#endregion Variables. ////////////////////



#region // Functions.

@warning_ignore("shadowed_variable")
func _init(\
		initial_offset: Vector2 = Vector2(0.0, 0.0), \
		speed: Vector2 = Vector2(5.0, 5.0), \
		amplitude: Vector2 = Vector2(10.0, 10.0)) \
	-> void:
	
	horizontal = initial_offset.x
	vertical = initial_offset.y
	
	self.speed = speed
	self.amplitude = amplitude


func advance(delta: float) -> void:
	horizontal += speed.x * delta
	vertical += speed.y * delta

#endregion Functions. ////////////////////
