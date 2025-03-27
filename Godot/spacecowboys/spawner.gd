extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
#might want to put the spawner separate from the player, not sure yet
@export var player:CharacterBody2D
const ENEMY_RESOURCE = preload("uid://dbg2ncmxaacx7")



func _on_spawn_timer_timeout() -> void:
	var enemy = ENEMY_RESOURCE.instantiate()
	get_parent().add_sibling(enemy)
	#This only does the lower right range i think, i will change
	enemy.global_position = global_position + Vector2(randi_range(40, 80),randi_range(40, 80)) 
	enemy.player = player
