extends CharacterBody2D
## Main Player Script. Used to run movement, Debug commands, and run weapon scripts.

## Player Values
@export_category("Player")
@export var speed := 65.0

## Gun Values, Including Enabled, Upgrade, and Fire Rate.
@export_category("Guns")
@export var RevolverEnabled := true ## Determines if the Gun is enabled or not.
@export var ShotgunEnabled := false ## Determines if the Gun is enabled or not.
@export var TommyEnabled := false ## Determines if the Gun is enabled or not.
# Gun Upgrades, Im assming the upgrade tree will just set a value so Bleh >:P
# These values refer to the exclusive path upgrades
# 0 is base, 1 and 2 refer to their upgrade trees
@export_group("Upgrades")
@export var RevolverUpgrade: int ## Gun Upgrades 0 is base, 1 and 2 refer to their upgrade trees
@export var ShotgunUpgrade: int ## Gun Upgrades 0 is base, 1 and 2 refer to their upgrade trees
@export var TommyUpgrade: int ## Gun Upgrades 0 is base, 1 and 2 refer to their upgrade trees

@export_group("Fire Rate")
@export var RevolverFireRate: float = 0.33 ## Time in seconds between shots
@export var ShotgunFireRate: float = 0.8 ## Time in seconds between shots
@export var TommyGunFireRate: float = 0.2 ## Time in seconds between shots

## Nodes for Script
@export_group("Nodes")
@export_subgroup("Gun Nodes") # Gun Nodes
@export var Revolver: Node
@export var Shotgun: Node
@export var TommyGun: Node
@export_subgroup("Fire Rate Timers") # Deals with Firerate
@export var RevolverTimer: Timer
@export var ShotgunTimer: Timer
@export var TommyGunTimer: Timer

@onready var hp = $"Hp Player/Health"

func _ready() -> void:
	Console.pause_enabled = true
	Console.add_command("dmg", dmg_player)
	Console.add_command("heal", heal_player)
	# This way fire rate is dynamic
	#RevolverTimer.start(RevolverFireRate)
	ShotgunTimer.start(ShotgunFireRate)
	#TommyGunTimer.start(TommyGunFireRate)

func _physics_process(delta: float) -> void:
	# Temp
	if Input.is_action_just_pressed("UpgradeTest"):
		ShotgunUpgrade = ShotgunUpgrade + 1
		if ShotgunUpgrade >= 3:
			ShotgunUpgrade = 0
	# Run directional Inputs.
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

#region debug Funcs
# -1 hp
func dmg_player():
	hp.current -= 1
# +1 hp
func heal_player():
	hp.current += 1
#endregion

## kid named infinite timers (i'm 3 seconds away from killing myself)
func _on_revolver_cooldown_timeout() -> void:
	Revolver.shoot(80.0)

func _on_shotgun_cooldown_timeout() -> void:
	Shotgun.shoot(80.0, 3, ShotgunUpgrade)

func _on_tommy_gun_cooldown_timeout() -> void:
	TommyGun.shoot(100.0)
