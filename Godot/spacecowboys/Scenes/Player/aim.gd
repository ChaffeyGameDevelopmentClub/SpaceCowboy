extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#region Player Aim
	#Aim Code
	# Gets sides of triangle
	var shoot_direction = (get_global_mouse_position() - global_position)
	#print("Dir:" + str(shoot_direction))
	
	var rad
	var angle
	# If x is negitive
	if shoot_direction.x < 0:
		rad = atan(shoot_direction.y / shoot_direction.x)
		angle = rad_to_deg(rad)
		angle -= 180
	# else
	else:
		rad = atan(shoot_direction.y / shoot_direction.x)
		angle = rad_to_deg(rad)
	# Rotates 
	self.set_rotation_degrees(angle)
	#endregion
	
	#Debug
	%Angle.text = "Angle: " + str(angle)
	%MousePos.text = "Dir:" + str(shoot_direction)
