extends Node2D

const BASIC_PROJECTILE = preload("res://Scenes/Player/Guns/shotgun_pellet.tscn")
const SHOTGUN_FRAG = preload("res://Scenes/Player/Guns/shotgun_frag.tscn")

const BASIC_SPRITE = preload("res://Assets/Art/Shotgun Pellet.png")
const FIRE_SPRITE = preload("res://Assets/Art/Shotgun Pellet fire.png")


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
		0: # Basic
			shotgunClass.speed = speed
			shotgunClass.count = count
			shotgunClass.Gun()
		1: # Fire
			shotgunClass.speed = speed
			shotgunClass.count = count
			shotgunClass.sprite = FIRE_SPRITE
			shotgunClass.Gun()
		2: # Frag
			pass

func _on_range_body_entered(body: Node2D) -> void:
	print("Body Enter")
	pass

func addToScene(node):
	get_tree().current_scene.add_child(node)

class ShotGun:
	var speed: int
	var count := 1
	var dmg := 1
	var sprite := BASIC_SPRITE
	var realself
	func Gun():
		for i in count:
			var projectile := BASIC_PROJECTILE.instantiate() # Instantiate Projectile
			realself.addToScene(projectile) # Add to scene
			projectile.get_node("HitBox2D").actions[0].amount = dmg
			projectile.get_node("Sprite2D").texture = sprite
			projectile.SPEED = speed # set speed to value passed through
			projectile.transform = realself.get_node('Spawner').global_transform # move projectile to spawn location
			projectile.rotate(deg_to_rad(randf_range(-25.0, 25))) # randomize spread
			projectile.ExpireTimer.start() # start expire timer
