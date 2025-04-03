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
