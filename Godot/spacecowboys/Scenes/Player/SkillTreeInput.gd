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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points = Global.skillPoints
	

func _skillpoints_changed():
	skillpoint_label.text = skillpoint_label_format.format([skilltree.max_unlock_cost])
	skill_reset.disabled = skilltree.max_unlock_cost >= starting_skillpoints
	var stat_list_text : Array[String] = []
	var stats_raw := skilltree.get_all_nodes()
	var stats := {}
	for k in stats_raw:
		var v : int = stats_raw[k]
		if v == 0: continue
		for node_data_item in k.data:
			# [SkillStats] is a resource specific to this example.
			# You can search for your own resource types,
			# or if you're using Wyvernshield, you can store stats in [StatModification]s.
			if node_data_item is SkillStats:
				stats[node_data_item.name] = stats.get(node_data_item.name, 0) + v * node_data_item.amount

	for k in stats:
		stat_list_text.append("%s: %s" % [k, stats[k]])

	stat_list.text = "\n".join(stat_list_text)
