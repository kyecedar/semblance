@tool
extends Node



#region // Signals.

# window.
signal window_focus
signal window_unfocus

#endregion Signals. ////////////////////



#region // Variables.

var window_focused : bool = false

#endregion Variables. 



#region // Functions.

func _ready() -> void:
	print_rich("[wave]🦋 Semblance[/wave] v" + ProjectSettings.get_setting("application/config/version"))
	
	randomize()
	
	if Engine.is_editor_hint():
		set_process_unhandled_input(false)
		set_process(false)
		return


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		window_focused = true
		window_focus.emit()
	elif what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		window_focused = false
		window_unfocus.emit()

#endregion Functions. ////////////////////
