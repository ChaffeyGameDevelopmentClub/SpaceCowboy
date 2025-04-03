extends Node2D
## Enemy 1 Script
## Basic Enemy that just slowly moves towards the player.
## Reference from [url]https://docs.godotengine.org/en/4.4/tutorials/navigation/navigation_using_navigationagents.html[/url]

const SPEED := 50.0

# From Docs
var movement_delta: float

# From Docs
@onready var navAgent: NavigationAgent2D = get_node("NavigationAgent2D")

@onready var state_machine: Node = get_node("StateMachine")
#@onready var animations
@onready var manager = get_parent()
@onready var level = manager.get_parent()
@onready var player = level.get_node("Player")

#region ready
func _ready() -> void:
	# Initalize State Machine
	state_machine.init(self)

	# From Docs
	navAgent.velocity_computed.connect(Callable(_on_velocity_computed))
#endregion


#region process
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	#region old movement
	## set tartget Pos
	#set_movement_target(player.position)
	#
	## Do not query when the map has never synchronized and is empty.
	#if NavigationServer2D.map_get_iteration_id(navAgent.get_navigation_map()) == 0:
		#print_debug("Nav Map Not Found")
		#return
	#if navAgent.is_navigation_finished():
		#print_debug("Nav Finished")
		#return
	#
	#movement_delta = SPEED * delta
	#var next_path_position: Vector2 = navAgent.get_next_path_position()
	#var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_delta
	#if navAgent.avoidance_enabled:
		#navAgent.set_velocity(new_velocity)
	#else:
		#_on_velocity_computed(new_velocity)
	#endregion
	
	##region debug window
	#var debugWindow = level.get_node("Player/Debug Window")
	#debugWindow.get_node("PlayerPos").text = "Player Pos: " + str(player.position)
	#debugWindow.get_node("NextPoint").text = "Next Point: " + str(next_path_position)
	#debugWindow.get_node("Velocity").text = "Velocity: " + str(new_velocity)
	##endregion
	
#endregion

func set_movement_target(movement_target: Vector2):
	navAgent.set_target_position(movement_target)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

func _on_health_died(_entity: Node) -> void:
	# might make a explosion?
	# need to add to var to give player xp
	queue_free()
