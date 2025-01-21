extends Node


#region // Variables.

var randgen : RandomNumberGenerator = RandomNumberGenerator.new()
var noise   : FastNoiseLite         = FastNoiseLite.new()

#endregion Variables. ////////////////////



#region // Functions.

func _ready() -> void:
	randgen.randomize()


func create_shaker(strength: float, speed: float, strength_decay: float = 0.0, speed_decay: float = 0.0) -> Shaker:
	return Shaker.new(strength, speed, strength_decay, speed_decay)

#endregion Variables. ////////////////////
