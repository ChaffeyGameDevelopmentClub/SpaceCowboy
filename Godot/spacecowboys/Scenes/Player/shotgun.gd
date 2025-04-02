extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/basic_projectile.tscn")
const SHOTGUN_FRAG = preload("res://Scenes/Player/shotgun_frag.tscn")

var shotgunClass

func _ready() -> void:
	shotgunClass = ShotGun.new()
	shotgunClass.realself = self

func shoot(speed: float, count: int, upgrade: int):
	#if upgrade == 0:
		#for i in count:
			#var projectile := BASIC_PROJECTILE.instantiate()
			#get_tree().current_scene.add_child(projectile)
			#projectile.SPEED = speed
			#projectile.transform = $Spawner.global_transform
			#projectile.rotate(deg_to_rad(randf_range(-25.0,25)))
			#projectile.ExpireTimer.start()
	#if upgrade == 1:
		#for i in count:
			#var projectile := BASIC_PROJECTILE.instantiate()
			#get_tree().current_scene.add_child(projectile)
			#projectile.SPEED = speed + 20.0
			#projectile.transform = $Spawner.global_transform
			#projectile.rotate(deg_to_rad(randf_range(-25.0,25)))
			#projectile.ExpireTimer.start()
	#if upgrade == 2:
		#var projectile := SHOTGUN_FRAG.instantiate()
		#get_tree().current_scene.add_child(projectile)
		#projectile.SPEED = speed - 20.0
		#projectile.transform = $Spawner.global_transform
		#projectile.ExpireTimer.start()
	match upgrade:
		0:
			shotgunClass.speed = speed
			shotgunClass.count = count
			shotgunClass.Gun()
			pass
		1:
			pass
		2:
			pass

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass

func addToScene(node):
	get_tree().current_scene.add_child(node)

class ShotGun:
	var speed : int
	var count := 1
	var dmg := 1
	var realself
	func Gun():
		for i in count:
			var projectile := BASIC_PROJECTILE.instantiate() # Instantiate Projectile
			realself.addToScene(projectile) # Add to scene
			projectile.get_node("HitBox2D").actions[0].amount = dmg
			projectile.SPEED = speed # set speed to value passed through
			projectile.transform = realself.get_node('Spawner').global_transform # move projectile to spawn location
			projectile.rotate(deg_to_rad(randf_range(-25.0,25))) # randomize spread
			projectile.ExpireTimer.start() # start expire timer
