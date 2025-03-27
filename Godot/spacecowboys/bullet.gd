extends Area2D


var SPEED:int = 30
var DIRECTION:Vector2 = Vector2(1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += SPEED * delta * DIRECTION




func _on_area_entered(area: Area2D) -> void:
	#We can make this depend on collision layer for performance
	if area.is_in_group("Enemy"):
		queue_free()
