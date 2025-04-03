extends CharacterBody2D
## Main Player Script. Used to run movement, Debug commands, and run weapon scripts.

#region Exports
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
@export_subgroup("Other Nodes")
@export var EnemyManager: Node2D
#endregion

var level := 1
var lvlUpThres := 100
var points := 0

@onready var hp = $"Hp Player/Health"
@onready var lvlBar = $GameUi/PanelContainer/Levelup/LevelupBar
@onready var lvlLabel = $GameUi/PanelContainer/LvlLabels/VBoxContainer/Lvl
@onready var pointsLabel = $GameUi/PanelContainer/LvlLabels/VBoxContainer/Points

func _ready() -> void:
	Console.pause_enabled = true
	Console.add_command("dmg", dmg_player, 0, 0, "Hurt Player")
	Console.add_command("heal", heal_player, 0, 0, "Heal Player")
	Console.add_command("lvlUp", lvlUp, 1, 1, "Lvl up Player by amount")
	
	# This way fire rate is dynamic
	if RevolverEnabled:
		RevolverTimer.start(RevolverFireRate)
	if ShotgunEnabled:
		ShotgunTimer.start(ShotgunFireRate)
	if TommyEnabled:
		TommyGunTimer.start(TommyGunFireRate)
	
	#lvl up
	lvlBar.max_value = lvlUpThres
	changeLvl(level)
	changePnt(points)

func _physics_process(_delta: float) -> void:
	# Open Upgrade Tree
	if Input.is_action_just_pressed("Upgrade") and points > 0:
		# Need to replace this code
		ShotgunUpgrade = ShotgunUpgrade + 1
		if ShotgunUpgrade >= 3:
			ShotgunUpgrade = 0
	
	lvlBar.value = Global.xp
	if Global.xp == lvlUpThres:
		lvlUpThres = lvlUpThres * 2.5
		level += 1
		points += 1
		changeLvl(level)
		changePnt(points)
		Global.xp = 0
	
	
	
	#region Run directional Inputs
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	#endregion


#region debug Funcs
# -1 hp
func dmg_player():
	hp.current -= 1
# +1 hp
func heal_player():
	hp.current += 1
func lvlUp(x: String):
	var lvl = int(x)
	if lvl == null:
		Console.print_line("Please Enter a Int")
	else:
		level += lvl
		points += lvl
		changeLvl(level)
		changePnt(points)
#endregion

func changeLvl(num):
	lvlLabel.text = "Lvl: " + str(num)
func changePnt(num):
	pointsLabel.text = "Points: " + str(num)

#region Signals
# Player Died
func _on_health_died(entity: Node) -> void:
	# Run death Screen
	EnemyManager.killAll()
	pass # Replace with function body.

# kid named infinite timers (i'm 3 seconds away from killing myself)
func _on_revolver_cooldown_timeout() -> void:
	Revolver.shoot(80.0)

func _on_shotgun_cooldown_timeout() -> void:
	Shotgun.shoot(80.0, 3, ShotgunUpgrade)

func _on_tommy_gun_cooldown_timeout() -> void:
	TommyGun.shoot(100.0)
#endregion
