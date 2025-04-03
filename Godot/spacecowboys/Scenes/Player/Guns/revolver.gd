extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/Guns/basic_projectile.tscn")

func shoot(speed: float):
	var projectile := BASIC_PROJECTILE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.SPEED = speed
	projectile.transform = $Spawner.global_transform
	projectile.ExpireTimer.start()

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass
