extends Control

@export var starting_skillpoints := 12
@export var skilltree : WorldmapView

@export_group("Bottom Bar")
@export var skillpoint_label : Label
@export var skillpoint_label_format := "{0} Points Left"
@export var skill_reset : BaseButton
@export var stat_list : Label

@export_group("Tooltip")
@export var tooltip_root : CanvasItem
@export var tooltip_title : Label
@export var tooltip_desc : Label

var points

@onready var player = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#skilltree.max_unlock_cost = starting_skillpoints # Not sure what this is for?
	#_skillpoints_changed() # Called on ready
	#tooltip_root.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points = Global.skillPoints
	
# From example - Edited Slightly
func _skillpoints_changed():
	# Formatting Point Label
	skillpoint_label.text = skillpoint_label_format.format([skilltree.max_unlock_cost])
	# Skill Reset button
	skill_reset.disabled = skilltree.max_unlock_cost >= starting_skillpoints
	# Display Stat Increases
	var stat_list_text : Array[String] = []
	var stats_raw := skilltree.get_all_nodes()
	var stats := {} # Need to pass this to player?
	for k in stats_raw:
		var v : int = stats_raw[k]
		if v == 0: continue
		# Need to make our own resource for this. 
		for node_data_item in k.data:
			# [SkillStats] is a resource specific to this example.
			# You can search for your own resource types,
			# or if you're using Wyvernshield, you can store stats in [StatModification]s.
			if node_data_item is SkillStats:
				stats[node_data_item.name] = stats.get(node_data_item.name, 0) + v * node_data_item.amount
				
	for k in stats:
		stat_list_text.append("%s: %s" % [k, stats[k]])
	# Write Stats to Label
	stat_list.text = "\n".join(stat_list_text)

# For mouse Input? 
func _on_map_node_gui_input(event : InputEvent, path : NodePath, node_in_path : int, resource : WorldmapNodeData):
	if event is InputEventMouseMotion: # Move tooltip to mouse pos
		tooltip_root.global_position = event.global_position

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			# If can get skill point? Lowers .max_unlock_cost
			if skilltree.get_node_state(path, node_in_path) <= 0:
				if skilltree.can_activate(path, node_in_path):
					tooltip_root.hide()
					skilltree.max_unlock_cost -= skilltree.set_node_state(path, node_in_path, 1)
					_skillpoints_changed()
			# Deactivate Skill?
			elif skilltree.can_deactivate(path, node_in_path):
				tooltip_root.hide()
				skilltree.max_unlock_cost -= skilltree.set_node_state(path, node_in_path, 0)
				_skillpoints_changed()
		# Remove Skill Node, Don't need this.
		#if event.button_index == MOUSE_BUTTON_MIDDLE && event.pressed:
			#skilltree.get_node(path).remove_node(node_in_path)

# Mouse Moves on tool tip? Displays Name and Desc
func _on_map_node_mouse_entered(_path : NodePath, _node_in_path : int, resource : WorldmapNodeData):
	tooltip_root.show()
	tooltip_title.text = resource.name
	tooltip_desc.text = resource.desc
	tooltip_root.size = Vector2.ZERO
# Mouse moves away from tooltip? Hides Tooltip
func _on_map_node_mouse_exited(_path : NodePath, _node_in_path : int, _resource : WorldmapNodeData):
	tooltip_root.hide()

# Reset Skills
func _on_reset_skills_pressed():
	skilltree.max_unlock_cost = starting_skillpoints
	skilltree.reset()
	_skillpoints_changed()

# Debug to add points
func _on_add_pressed() -> void:
	skilltree.max_unlock_cost += 1
	_skillpoints_changed()
