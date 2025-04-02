extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/basic_projectile.tscn")
const SHOTGUN_FRAG = preload("res://Scenes/Player/shotgun_frag.tscn")

func shoot(speed: float, count: int, upgrade: int):
	if upgrade == 0:
		for i in count:
			var projectile := BASIC_PROJECTILE.instantiate()
			get_tree().current_scene.add_child(projectile)
			projectile.SPEED = speed
			projectile.transform = $Spawner.global_transform
			projectile.rotate(deg_to_rad(randf_range(-25.0,25)))
			projectile.ExpireTimer.start()
	if upgrade == 1:
		for i in count:
			var projectile := BASIC_PROJECTILE.instantiate()
			get_tree().current_scene.add_child(projectile)
			projectile.SPEED = speed + 20.0
			projectile.transform = $Spawner.global_transform
			projectile.rotate(deg_to_rad(randf_range(-25.0,25)))
			projectile.ExpireTimer.start()
	if upgrade == 2:
		var projectile := SHOTGUN_FRAG.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.SPEED = speed - 20.0
		projectile.transform = $Spawner.global_transform
		projectile.ExpireTimer.start()

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass
