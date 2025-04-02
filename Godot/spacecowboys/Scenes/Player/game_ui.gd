extends Control

@export var health: Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hpC = health.current
	var hpMax = health.max
	var hpValue: float = ((hpC * 1.0) / (hpMax * 1.0)) * 100
	$PanelContainer/Health/Label.text = str(int(hpValue)) + "%"
	$PanelContainer/Health2/ProgressBar.value = hpValue
	
	pass
