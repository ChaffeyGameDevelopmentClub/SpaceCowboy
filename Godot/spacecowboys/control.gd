extends Control

@export var p1 : Node2D
@export var p2 : Node2D

@export var line : Node2D

var move

func _ready() -> void:
	move = 1
	Console.add_command("line", lineDraw,2,2)
	
func _process(delta: float) -> void:
	p2.position.x += move
	lineDraw(p1,p2)


func lineDraw(point1,point2):
	line.points[0] = point1.position
	line.points[1] = point2.position


func _on_timer_timeout() -> void:
	move *= -1
