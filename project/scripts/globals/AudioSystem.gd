extends Node

# TODO:
# x set custom frequency range listeners.
# x get/refresh lists of audio devices.
# x set audio device of recording bus.



#region // Variables.

var bus_index         : int
var recording         : AudioStreamWAV
var spectrum_analyzer : AudioEffectSpectrumAnalyzerInstance

var frequencies : Array[FreqRangeMag] = []
var peak_volume : float = 0.0

var input_device  : String :
	get():
		return AudioServer.input_device
	set(device_name):
		AudioServer.input_device = device_name

var input_devices : PackedStringArray :
	get():
		return AudioServer.get_input_device_list()

#endregion Variables. ////////////////////



#region // Functions.

func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Record")
	spectrum_analyzer = AudioServer.get_bus_effect_instance(bus_index, 1)
	
	create_frequency_range(0, 500)


func _process(_delta: float) -> void:
	var sample : float = AudioServer.get_bus_peak_volume_left_db(bus_index, 0)
	
	peak_volume = db_to_linear(sample)
	
	for frequency in frequencies:
		var mag = spectrum_analyzer.get_magnitude_for_frequency_range(frequency.low, frequency.high).length()
		frequency.magnitude = mag
		#var _magnitude_db = linear_to_db(frequency.magnitude)
	
	
	#print("%s db" % round(magnitude_db))

## 
func create_frequency_range(low_hz: float, high_hz: float) -> int:
	var idx : int = len(frequencies)
	
	var frequency = FreqRangeMag.new(low_hz, high_hz)
	
	frequencies.push_back(frequency)
	
	return idx


func set_input_device(device_name: String) -> void:
	AudioServer.input_device = device_name

#endregion Functions. ////////////////////
