extends Camera2D

var dragging = false

# from https://docs.godotengine.org/en/4.4/tutorials/inputs/input_examples.html#mouse-motion
#region Test drag
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Start dragging if the click is on the sprite.
		if not dragging and event.pressed:
			dragging = true
			
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move cam with mouse
		self.position += event.relative * -1
		
#endregion
