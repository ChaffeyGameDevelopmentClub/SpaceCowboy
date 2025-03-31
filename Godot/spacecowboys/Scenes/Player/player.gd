extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var gun:Node

func _physics_process(delta: float) -> void:

	# Handle jump.
	if Input.is_action_just_pressed("Shoot"):
		gun.shoot()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("Move Left", "Move Right","Move Up","Move Down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
