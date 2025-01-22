extends Control



#region // Variables.

enum ViewportPosition {
	BOTTOM_LEFT,
	TOP_LEFT,
	BOTTOM_RIGHT,
	TOP_RIGHT,
}

enum ResizerPosition {
	NONE,
	TOP,
	TOP_RIGHT,
	RIGHT,
	BOTTOM_RIGHT,
	BOTTOM,
	BOTTOM_LEFT,
	LEFT,
	TOP_LEFT,
}

@export var viewport_background_color : Color = Color() : set = _set_viewport_background_color
@export var fade_background_color     : Color = Color()

var fade_out_rate : float =  7.0
var fade_in_rate  : float = 10.0
var alpha         : float =  1.0

var dragging_panel : ResizerPosition = ResizerPosition.NONE
var panel_offset   : Vector2i = Vector2i.ZERO
var viewport_position : ViewportPosition = ViewportPosition.BOTTOM_LEFT : set = _set_viewport_position
var resizer_size : int = 8 ## in pixels.

#endregion Variables. ////////////////////



#region // Functions.

func _ready() -> void:
	%ViewportResizerVertical.gui_input.connect(_on_viewport_resizer_vertical_gui_input)
	%ViewportResizerCorner.gui_input.connect(_on_viewport_resizer_corner_gui_input)
	%ViewportResizerHorizontal.gui_input.connect(_on_viewport_resizer_horizontal_gui_input)
	call_deferred("update_viewport_resize_handles")


func _process(delta: float) -> void:
	handle_background_colors(delta)
	drag_resizers()


func handle_background_colors(delta: float) -> void:
	if Semblance.window_focused:
		alpha = lerp(alpha, 1.0, delta * fade_in_rate)
	else:
		alpha = lerp(alpha, 0.0, delta * fade_out_rate)
	
	var color : Color = Color(fade_background_color.r, fade_background_color.g, fade_background_color.b, alpha)
	
	%DataFadeInBackground.modulate  = color
	%KnobsFadeInBackground.modulate = color


func _set_viewport_position(value: ViewportPosition) -> void:
	viewport_position = value
	call_deferred("_internal_set_viewport_position")

func _internal_set_viewport_position() -> void:
	match viewport_position:
		ViewportPosition.BOTTOM_LEFT:
			pass
		ViewportPosition.TOP_LEFT:
			pass
		ViewportPosition.BOTTOM_RIGHT:
			pass
		ViewportPosition.TOP_RIGHT:
			pass


func update_viewport_resize_handles() -> void:
	%ViewportResizerVertical.size = Vector2(%ViewportContainer.size.x, resizer_size)
	%ViewportResizerCorner.size = Vector2(resizer_size, resizer_size)
	%ViewportResizerHorizontal.size = Vector2(resizer_size, %ViewportContainer.size.y)
	
	match viewport_position:
		ViewportPosition.BOTTOM_LEFT:
			%ViewportResizerVertical.position.x = 0.0
			%ViewportResizerVertical.position.y = %DataContainer.size.y - resizer_size
			
			%ViewportResizerHorizontal.position.x = %ViewportContainer.size.x
			%ViewportResizerHorizontal.position.y = %DataContainer.size.y
			
			%ViewportResizerCorner.position.x = %ViewportContainer.size.x
			%ViewportResizerCorner.position.y = %DataContainer.size.y - resizer_size
		ViewportPosition.TOP_LEFT:
			%ViewportResizerVertical.position.x = 0.0
			%ViewportResizerVertical.position.y = %ViewportContainer.size.y
			
			%ViewportResizerHorizontal.position.x = %ViewportContainer.size.x
			%ViewportResizerHorizontal.position.y = 0.0
			
			%ViewportResizerCorner.position.x = %ViewportContainer.size.x
			%ViewportResizerCorner.position.y = 0.0
		ViewportPosition.BOTTOM_RIGHT:
			pass


func drag_resizers() -> void:
	var window_size : Vector2i = get_window().size
	
	match dragging_panel:
		ResizerPosition.NONE:
			return
		
		ResizerPosition.TOP:
			pass
			#%ViewportContainerContainer.custom_minimum_size.y
			%ViewportResizerVertical.position.y = min(max(get_local_mouse_position().y + panel_offset.y, 0.0), window_size.y - resizer_size)
			%ViewportContainerContainer.custom_minimum_size.y = window_size.y - (%ViewportResizerVertical.position.y + resizer_size)
		ResizerPosition.BOTTOM:
			pass
			#%ViewportResizerVertical.position.y = get_local_mouse_position().y + panel_offset.y
			
		ResizerPosition.LEFT:
			pass
			#%ViewportResizerHorizontal.position.x = get_local_mouse_position().x + panel_offset.x
		ResizerPosition.RIGHT:
			pass
			%ViewportResizerHorizontal.position.x = min(max(get_local_mouse_position().x + panel_offset.x, 0.0), window_size.x - resizer_size)
			#%ViewportResizerHorizontal.position.x = get_local_mouse_position().x + panel_offset.x
			%ViewportAndData.custom_minimum_size.x = %ViewportResizerHorizontal.position.x
		
		_:
			pass
			#%ViewportResizerCorner.position.x = get_local_mouse_position().x + panel_offset.x
			#%ViewportResizerCorner.position.y = get_local_mouse_position().y + panel_offset.y


#region // DRAGGING RESIZER.

func dragging_vertical_resizer(resizer_position: ResizerPosition) -> void:
	if dragging_panel == resizer_position:
		return
	
	panel_offset = %ViewportResizerVertical.global_position - get_local_mouse_position()
	dragging_panel = resizer_position

func dragging_corner_resizer(resizer_position: ResizerPosition) -> void:
	if dragging_panel == resizer_position:
		return
	
	panel_offset = %ViewportResizerCorner.global_position - get_local_mouse_position()
	dragging_panel = resizer_position

func dragging_horizontal_resizer(resizer_position: ResizerPosition) -> void:
	if dragging_panel == resizer_position:
		return
	
	panel_offset = %ViewportResizerHorizontal.global_position - get_local_mouse_position()
	dragging_panel = resizer_position

#endregion DRAGGING RESIZER. ////////////////////


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton):
		return
		
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
		
	if event.pressed:
		return
	
	dragging_panel = ResizerPosition.NONE

func _on_viewport_resizer_vertical_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if \
				viewport_position == ViewportPosition.BOTTOM_LEFT || \
				viewport_position == ViewportPosition.BOTTOM_RIGHT:
					dragging_vertical_resizer(ResizerPosition.TOP)
				else:
					dragging_vertical_resizer(ResizerPosition.BOTTOM)

func _on_viewport_resizer_corner_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				match viewport_position:
					ViewportPosition.TOP_LEFT:
						dragging_corner_resizer(ResizerPosition.BOTTOM_RIGHT)
					ViewportPosition.TOP_RIGHT:
						dragging_corner_resizer(ResizerPosition.BOTTOM_LEFT)
					ViewportPosition.BOTTOM_LEFT:
						dragging_corner_resizer(ResizerPosition.TOP_RIGHT)
					ViewportPosition.BOTTOM_RIGHT:
						dragging_corner_resizer(ResizerPosition.TOP_LEFT)

func _on_viewport_resizer_horizontal_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if \
				viewport_position == ViewportPosition.TOP_LEFT || \
				viewport_position == ViewportPosition.BOTTOM_LEFT:
					dragging_horizontal_resizer(ResizerPosition.RIGHT)
				else:
					dragging_horizontal_resizer(ResizerPosition.LEFT)


func _set_viewport_background_color(color: Color) -> void:
	viewport_background_color = color
	call_deferred("_internal_set_viewport_background_color", color)


func _internal_set_viewport_background_color(color: Color) -> void:
	%ViewportBackground.modulate = color

#endregion Functions. ////////////////////
