extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/basic_projectile.tscn")

@export var Team := 1
@export var level : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(find_parent("Player").get_parent().get_tree_string_pretty())
	print(get_tree().current_scene.get_tree_string_pretty())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(speed: float, count: int):
	var shoot_direction = (get_global_mouse_position() - global_position).normalized()
	var projectile := BASIC_PROJECTILE.instantiate()
	for i in count:
		get_tree().current_scene.add_child(projectile)
		projectile.SPEED = speed
		projectile.transform = $Spawner.global_transform

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass
