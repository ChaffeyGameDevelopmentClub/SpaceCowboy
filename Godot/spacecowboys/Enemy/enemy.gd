extends CharacterBody2D


const SPEED = 10

var health:int = 5

var player = null

func _physics_process(delta: float) -> void:
	if player:
		var direction:Vector2 = (player.global_position - global_position).normalized()
		if direction:
			velocity = direction * SPEED 
	else:
		velocity = Vector2(0,0);
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	#We can make this depend on collision layer for performance
	if area.is_in_group("Bullet"):
		health-=1
		if health==0:
			queue_free()
