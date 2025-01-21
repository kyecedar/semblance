extends Node
class_name Shaker

## https://shaggydev.com/2022/02/23/screen-shake-godot/



#region // Variables.

static var noise   : FastNoiseLite         = FastNoiseLite.new()
static var randgen : RandomNumberGenerator = RandomNumberGenerator.new()

var noise_step : float   = 0.0
var offset     : Vector2 = Vector2.ZERO
var strength   : float   = 0.0
var speed      : float   = 0.0

var noise_seed : Vector2i = Vector2i(1, 100)

## Rate at which shake strength decays.[br]
## Multiplied by delta. Higher number, more decay. Minimum is 0.0, which means no decay.
var strength_decay : float = 0.0 :
	set(value):
		strength_decay = max(value, 0.0)

## Rate at which shake speed decays.[br]
## Multiplied by delta. Higher number, more decay. Minimum is 0.0, which means no decay.
var speed_decay : float = 0.0 :
	set(value):
		speed_decay = max(value, 0.0)

#endregion Variables. ////////////////////



#region // Functions.

@warning_ignore("shadowed_variable")
func _init(strength: float, speed: float, strength_decay: float = 0.0, speed_decay: float = 0.0) -> void:
	self.strength = strength
	self.speed = speed
	self.strength_decay = strength_decay
	self.speed_decay = speed_decay

func advance(delta: float) -> void:
	noise_step += delta * speed
	
	# "set the x values of each call to 'get_noise_2d' to a different value,
	# so that our x and y values will be reading from unrelated areas of noise."
	
	offset = Vector2(
		noise.get_noise_2d(noise_seed.x, noise_step) * strength,
		noise.get_noise_2d(noise_seed.y, noise_step) * strength
	)
	
	# decay shake.
	strength = lerp(strength, 0.0, strength_decay)
	speed = lerp(speed, 0.0, speed_decay)

func randomize_noise() -> Shaker:
	randgen.randomize()
	
	noise_seed.x = randgen.randi_range(1, 500)
	noise_seed.y = randgen.randi_range(1, 500)
	
	return self

#endregion Functions. ////////////////////
