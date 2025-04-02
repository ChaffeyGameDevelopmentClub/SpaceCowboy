extends CharacterBody2D
## Main Player Script. Used to run movement, Debug commands, and run weapon scripts.

const SPEED = 75.0

@export_group("Nodes")
@export var Revolver:Node
@export var Shotgun:Node

@onready var hp = $"Hp Player/Health"

func _ready() -> void:
	Console.add_command("dmg", dmg_player)
	Console.add_command("heal", heal_player)

func _physics_process(delta: float) -> void:
	# On click Shoot. Will be replaced when Auto aim is made.
	if Input.is_action_just_pressed("Shoot"):
		Revolver.shoot(80.0)
		Shotgun.shoot(80.0, 3)
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
