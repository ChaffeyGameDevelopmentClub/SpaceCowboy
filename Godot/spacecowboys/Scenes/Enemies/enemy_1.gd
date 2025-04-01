extends Node2D
## Enemy Script

@export_group("Nodes")
@export var navAgent : NavigationAgent2D

var manager
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	manager = get_parent()
	player = manager.get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	setTarget(player)
	
	pass

func setTarget(target):
	navAgent.target_position = target.position
	pass

func nextPoint(navAgent):
	var np = navAgent.get_next_path_position()
	
	pass

func _on_health_died(entity: Node) -> void:
	queue_free()
