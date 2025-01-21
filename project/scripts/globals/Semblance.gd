@tool
extends Node



#region // Signals.

# window.
signal window_focus
signal window_unfocus

#endregion Signals. ////////////////////



#region // Variables.

var window_focused : bool = true

#endregion Variables. ////////////////////



#region // Functions.

func _ready() -> void:
	print_rich("\n[wave amp=80.0 freq=1.0 connected=0]🦋 Semblance v" + ProjectSettings.get_setting("application/config/version") + "[/wave]\n")
	
	randomize()
	
	call_deferred("_init_window_focused")
	
	if Engine.is_editor_hint():
		set_process_unhandled_input(false)
		set_process(false)
		return


func _init_window_focused() -> void:
	window_focused = get_window().has_focus()


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		window_focused = true
		window_focus.emit()
	elif what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		window_focused = false
		window_unfocus.emit()

#endregion Functions. ////////////////////
