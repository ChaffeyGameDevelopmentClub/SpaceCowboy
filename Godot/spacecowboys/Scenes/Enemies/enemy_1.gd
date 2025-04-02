extends Node2D
## Enemy Script

const SPEED := 25.0

@export_group("Nodes")

# From Docs
var movement_delta : float

var manager
var level
var player

# From Docs
@onready var navAgent : NavigationAgent2D = get_node("NavigationAgent2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	manager = get_parent()
	level = manager.get_parent()
	player = level.get_node("Player")
	
	# From Docs
	navAgent.velocity_computed.connect(Callable(_on_velocity_computed))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_movement_target(player.position)
	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navAgent.get_navigation_map()) == 0:
		print_debug("Nav Map Not Found")
		return
	if navAgent.is_navigation_finished():
		print_debug("Nav Finished")
		return
	
	movement_delta = SPEED * delta
	var next_path_position: Vector2 = navAgent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_delta
	if navAgent.avoidance_enabled:
		navAgent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	
	#region debug window
	print("debug Window\n")
	var debugWindow = level.get_node("Player/Debug Window")
	print(level.get_tree_string_pretty())
	print(level.name)
	print(debugWindow.name)
	debugWindow.get_node("PlayerPos").text = "Player Pos: " + str(player.position)
	debugWindow.get_node("NextPoint").text = "Next Point: " + str(next_path_position)
	debugWindow.get_node("Velocity").text = "Velocity: " + str(new_velocity)
	#endregion
func set_movement_target(movement_target: Vector2):
	navAgent.set_target_position(movement_target)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)



#func nextPoint():
	#var np = navAgent.get_next_path_position()
	#self.position += lerp(self.position,np,SPEED)

func _on_health_died(entity: Node) -> void:
	queue_free()
