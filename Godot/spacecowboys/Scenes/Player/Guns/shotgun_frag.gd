class_name ShotgunFrag extends Node2D
## Shotgun Frag Projectile, used exclusively by the Shotgun Frag Tree

const BASIC_PROJECTILE = preload("res://Scenes/Player/Guns/basic_projectile.tscn")

# Editble Values
@export var SPEED: float # Speed of the projectile
@export var hit_box: HitBox2D
@export var Sprite: Sprite2D
@export var SpriteTexture: String # Sprite Texture path
@export var ExpireTimer: Timer

func _ready() -> void:
	hit_box.action_applied.connect(_on_action_applied)
	Sprite.texture = load(SpriteTexture)

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_action_applied(_hurt_box: HurtBox2D) -> void:
	hit_box.ignore_collisions = true
	explode(6, 80.0, true)

# rex sploded
func explode(count: int, speed: float, touched: bool):
	for i in count:
		var projectile := BASIC_PROJECTILE.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.SPEED = speed
		projectile.transform = hit_box.global_transform
		projectile.rotate(deg_to_rad(randf_range(-180.0, 180)))
		projectile.ExpireTimer.start()
	queue_free()

# Explodes on a timer if it doesn't hit an enemy
func _on_expire_timer_timeout() -> void:
	explode(6, 80.0, false)
