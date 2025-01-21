extends Node
class_name FreqRangeMag

# FreqRangeMag : Frequency Range Magnitude



var low       : int = 0
var high      : int = 100
var magnitude : float = 0.0
var db        : float :
	get():
		return linear_to_db(magnitude)

func _init(low_hz: float, high_hz: float) -> void:
	self.low = low_hz
	self.high = high_hz
