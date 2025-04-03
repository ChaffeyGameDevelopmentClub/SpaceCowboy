extends State
## Idle State for enemies

@export var move_state: State

func enter() -> void:
	super ()
	#parent.velocity.x = 0

func process_frame(_delta: float) -> State:
	#parent.velocity.y += gravity * delta
	#parent.move_and_slide()
	#
	#if !parent.is_on_floor():
		#return fall_state
	return null
