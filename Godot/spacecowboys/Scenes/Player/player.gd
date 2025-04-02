extends CharacterBody2D
## Main Player Script. Used to run movement, Debug commands, and run weapon scripts.

const SPEED = 75.0

# Nodes for Guns
@export_group("Nodes")
@export var Revolver:Node
@export var Shotgun:Node
@export var TommyGun:Node

@export var RevolverTimer:Timer
@export var ShotgunTimer:Timer
@export var TommyGunTimer:Timer

# Gun Upgrades, Im assming the upgrade tree will just set a value so Bleh >:P
# These values refer to the exclusive path upgrades
# 0 is base, 1 and 2 refer to their upgrade trees
@export_group("Upgrades")
@export var RevolverUpgrade:int
@export var ShotgunUpgrade:int
@export var TommyUpgrade:int

@export_category("Values")
@export var RevolverFireRate:float = 0.33
@export var ShotgunFireRate:float = 0.8
@export var TommyGunFireRate:float = 0.2

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
	var direction := Input.get_vector("Move Left", "Move Right","Move Up","Move Down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
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
