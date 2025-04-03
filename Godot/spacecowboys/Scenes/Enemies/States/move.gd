extends State

#@export var idle_state: State

@export var speed: float = 50

func enter() -> void:
	super ()
	print_debug("Move State Entered")

func process_frame(delta: float) -> State:
	# set tartget Pos
	parent.set_movement_target(parent.player.position)
	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(parent.navAgent.get_navigation_map()) == 0:
		print_debug("Nav Map Not Found")
		return
	if parent.navAgent.is_navigation_finished():
		print_debug("Nav Finished")
		return
	
	parent.movement_delta = speed * delta
	var next_path_position: Vector2 = parent.navAgent.get_next_path_position()
	var new_velocity: Vector2 = parent.global_position.direction_to(next_path_position) * parent.movement_delta
	if parent.navAgent.avoidance_enabled:
		parent.navAgent.set_velocity(new_velocity)
	else:
		parent._on_velocity_computed(new_velocity)
	
	return null
