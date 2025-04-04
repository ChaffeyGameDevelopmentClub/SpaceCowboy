class_name BasicProjectile extends Node2D
## Basic Projectile, used by Revolver, Shotgun, and Tommy Gun

# Editble Values
@export var SPEED: float # Speed of the projectile
@export var hit_box: HitBox2D
@export var Sprite: Sprite2D
@export var SpriteTexture: String # Sprite Texture path
@export var Incendiary: bool # If the projectile sets people on fire or not
@export var ExpireTimer: Timer # Prevents projectile from drifting forever
@export var IFrameTimer: Timer # Prevents stuff like the Frag Shotgun's explosion projectiles from hitting the enemy on spawn

func _ready() -> void:
	hit_box.action_applied.connect(_on_action_applied)
	Sprite.texture = load(SpriteTexture)

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_action_applied(_hurt_box: HurtBox2D) -> void:
	hit_box.ignore_collisions = true
	queue_free()

func _on_expire_timer_timeout() -> void:
	queue_free()
