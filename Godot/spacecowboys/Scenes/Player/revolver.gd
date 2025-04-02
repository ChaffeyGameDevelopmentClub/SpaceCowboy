extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/basic_projectile.tscn")

@export var Team := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(speed: float):
	var projectile := BASIC_PROJECTILE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.SPEED = speed
	projectile.transform = $Spawner.global_transform

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass
