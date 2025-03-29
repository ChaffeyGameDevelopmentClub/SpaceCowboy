extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/basic_projectile.tscn")


@export var Team := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot():
	var projectile := BASIC_PROJECTILE.instantiate()
	find_parent("Player").add_child(projectile)
	#Team.setTeam(team, projectile.hit_box)
	#projectile.transform = $Spawner.global_transform



func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass
