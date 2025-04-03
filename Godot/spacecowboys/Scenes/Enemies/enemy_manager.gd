extends Node2D
## Spawns new Enemies

# Load Enemy scenes
const ENEMY1 = preload("res://Scenes/Enemies/enemy_1.tscn")
const ENEMY2 = preload("res://Scenes/Enemies/enemy_2.tscn")

@export var spawnRadius = 500 ## The max radius they will spawn from the player
@export var protectionRadius = 150 ## The radius from the player they can't spawn in

## Amount of Enemies to be spawned
var spawnAmount
var rand

@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	# Add Console Commands
	Console.add_command("spawnGroup", consoleSpawn, 1, 1, "Spawns a group with specified amount")
	Console.add_command("killAll", killAll)
	
	rand = RandomNumberGenerator.new()
	rand.randomize()
	
	spawnAmount = 5

	spawn_group(spawnAmount)
	%SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## Used to pass a string to a int for Console commands
func consoleSpawn(amount: String):
	spawn_group(int(amount))

## Spawns a group based on [param amount]
func spawn_group(amount: int):
	rand.randomize()
	# Instantiate new Enemy Group
	Console.print_line("%s Spawned" % amount)
	var enemy: Array[Node] = []
	for i in amount:
		var type = rand.randi_range(0,1)
		match type:
			0:
				enemy.push_back(ENEMY1.instantiate())
			1:
				enemy.push_back(ENEMY2.instantiate())
		# Adds to scene
		self.add_child(enemy[i])
		# Positions Enemy Group
		var pos = player.global_transform
		Console.print_line(player.global_transform)
		pos.origin = Vector2(
			rand.randi_range(-1 * rand.randi_range(spawnRadius, protectionRadius),
			rand.randi_range(spawnRadius, protectionRadius)),
			rand.randi_range(-1 * rand.randi_range(spawnRadius, protectionRadius),
			rand.randi_range(spawnRadius, protectionRadius)))
		enemy[i].transform = pos
		Console.print_line(enemy[i].position)

## Kills all spawned enemies
func killAll():
	var children = get_children()
	for child in children:
		child.queue_free()
	
func _on_spawn_timer_timeout() -> void:
	spawn_group(spawnAmount)
	if spawnAmount < 30:
		spawnAmount += 5
	elif spawnAmount < 100:
		spawnAmount += 15
	else:
		spawnAmount += 30
