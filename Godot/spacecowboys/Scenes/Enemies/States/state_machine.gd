extends Node

#@export_enum("Idle","Move") var starting_state: int

@export var starting_state : State

var current_state: State

func init(parent: Node2D) -> void:
	for child in get_children():
		child.parent = parent
	change_state(starting_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


# Pass through functions for the enemy to call,
# handling state changes as needed.
func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
