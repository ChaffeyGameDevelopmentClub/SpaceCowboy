extends Control

@export var UpgradeMenu : Control

var menu_up = false

@onready var player = get_parent().get_parent()

func _input(event): 
	if Input.is_action_just_pressed("Upgrade") and Global.skillPoints > 0:
		if menu_up:
			UpgradeMenu.hide()
			get_tree().paused = false
			menu_up = false
		else:
			UpgradeMenu.show()
			get_tree().paused = true
			menu_up = true
