extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health:int = 10


const BULLET_RESOURCE = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0);
	move_and_slide()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		var shoot_direction = get_global_mouse_position() - global_position
		var bullet = BULLET_RESOURCE.instantiate()
		add_sibling(bullet)
		bullet.global_position = global_position
		bullet.SPEED = 5
		bullet.DIRECTION = shoot_direction
