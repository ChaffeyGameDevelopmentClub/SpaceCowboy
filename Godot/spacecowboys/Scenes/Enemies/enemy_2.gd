extends Node2D
## Enemy 2 Script
## Charger type enemy.
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
	
#endregion

func set_movement_target(movement_target: Vector2):
	navAgent.set_target_position(movement_target)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

func _on_health_died(_entity: Node) -> void:
	# might make a explosion?
	# need to add to var to give player xp
	queue_free()
