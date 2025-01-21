extends Node



#region // Signals.

signal upon_keypress(keypress: Keypress)
signal upon_keyrelease(keypress: Keypress)

signal upon_internal_keypress(keypress: Keypress)
signal upon_internal_keyrelease(keypress: Keypress)
signal upon_external_keypress(keypress: Keypress)
signal upon_external_keyrelease(keypress: Keypress)

signal upon_click()
signal upon_upclick()
signal upon_internal_click()
signal upon_internal_upclick()
signal upon_external_click()
signal upon_external_upclick()

#endregion Signals. ////////////////////



#region // Functions.

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			var keypress = Keypress.new(event)
			upon_keypress.emit(keypress)
			
			if Semblance.window_focused:
				upon_internal_keypress.emit(keypress)
			else:
				upon_external_keypress.emit(keypress)
		else:
			var keyrelease = Keypress.new(event)
			upon_keyrelease.emit(keyrelease)
			
			if Semblance.window_focused:
				upon_internal_keyrelease.emit(keyrelease)
			else:
				upon_external_keyrelease.emit(keyrelease)
	if event is InputEventMouseButton:
		pass

#endregion Functions. ////////////////////
