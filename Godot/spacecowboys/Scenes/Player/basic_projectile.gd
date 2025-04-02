class_name BasicProjectile extends Node2D
## Basic Projectile, used by Revolver, Shotgun, and Tommy Gun

# Editble Values
@export var SPEED: float # Speed of the projectile
@export var hit_box: HitBox2D
@export var Sprite: Sprite2D
@export var SpriteTexture: String # Sprite Texture path
@export var Incendiary: bool # If the projectile sets people on fire or not

func _ready() -> void:
	hit_box.action_applied.connect(_on_action_applied)
	Sprite.texture = load(SpriteTexture)

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_action_applied(_hurt_box: HurtBox2D) -> void:
	hit_box.ignore_collisions = true
	# Handles piercing 
	queue_free()
