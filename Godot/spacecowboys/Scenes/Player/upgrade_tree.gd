extends Control

@export var UpgradeMenu : Control

var menu_up = false

func _input(event): 
	if Input.is_action_just_pressed("Upgrade"):
		if menu_up:
			UpgradeMenu.hide()
			get_tree().paused = false
			menu_up = false
		else:
			UpgradeMenu.show()
			get_tree().paused = true
			menu_up = true
