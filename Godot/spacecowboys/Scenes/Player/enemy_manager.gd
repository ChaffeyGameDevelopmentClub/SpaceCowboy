extends Node2D
## Spawns new Enemies

const ENEMY1 = preload("res://Scenes/Enemies/enemy_1.tscn")

@export var spawnRadius = 500
@export var protectionRadius = 150

var amount
var rand

@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Console.add_command("spawnGroup",consoleSpawn,1,1,"Spawns a group with specified amount")
	Console.add_command("killAll", killAll)
	
	rand = RandomNumberGenerator.new()
	rand.randomize()
	
	amount = 5

	spawn_group(amount)
	%SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func consoleSpawn(amount : String):
	spawn_group(int(amount))

func spawn_group(amount : int):
	rand.randomize()
	# Instantiate new Enemy Group
	Console.print_line("%s Spawned" % amount)
	var enemy : Array[Node] = []
	for i in amount:
		enemy.push_back(ENEMY1.instantiate())
		# Adds to scene
		self.add_child(enemy[i])
		# Positions Enemy Group
		var pos = player.global_transform
		Console.print_line(player.global_transform)
		pos.origin = Vector2(
			rand.randi_range(-1*rand.randi_range(spawnRadius,protectionRadius),
			rand.randi_range(spawnRadius,protectionRadius)),
			rand.randi_range(-1*rand.randi_range(spawnRadius,protectionRadius),
			rand.randi_range(spawnRadius,protectionRadius)))
		enemy[i].transform = pos
		Console.print_line(enemy[i].position)
	
func killAll():
	var children = get_children()
	for child in children:
		child.queue_free()
	
func _on_spawn_timer_timeout() -> void:
	spawn_group(amount)
	if amount < 30:
		amount += 5
	elif amount < 100:
		amount += 15
	else:
		amount += 30
