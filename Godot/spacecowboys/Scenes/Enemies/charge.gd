extends State

#@export var idle_state: State

@export var ChargeSpeed: float = 100.0
@export_group("States")
@export var move_state: State

var Delta
var new_velocity: Vector2
var chargeDone: bool

@onready var ChargeTime = $ChargeTime
@onready var TargetTime = $TargetTime

func enter() -> void:
	super ()
	print_debug("Charge State Entered")
	ChargeTime.start()
	chargeDone = false

func process_frame(delta: float) -> State:
	Delta = delta
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(parent.navAgent.get_navigation_map()) == 0:
		print_debug("Nav Map Not Found")
		return
	#if parent.navAgent.is_navigation_finished():
		#print_debug("Nav Finished")
		#return
		
	if chargeDone:
		return move_state
	
	return null

func _on_charge_time_timeout() -> void:
	# set tartget Pos on enter
	parent.set_movement_target(parent.player.position)
	parent.movement_delta = ChargeSpeed * Delta # Set Speed
	var next_path_position: Vector2 = parent.navAgent.get_next_path_position() # Should target players pos on timeout
	new_velocity = parent.global_position.direction_to(next_path_position) * parent.movement_delta # sets new velocity
	if parent.navAgent.avoidance_enabled:
		parent.navAgent.set_velocity(new_velocity)
	else:
		parent._on_velocity_computed(new_velocity)
	TargetTime.start()

func _on_target_time_timeout() -> void:
	chargeDone = true
