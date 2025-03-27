extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player = null

func _physics_process(delta: float) -> void:
	var direction = player.global_position - global_position
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0);

	move_and_slide()
