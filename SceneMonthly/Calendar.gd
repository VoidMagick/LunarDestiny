extends Node2D

var Week = preload("res://SceneMonthly/Week.tscn")

var weekNum = 40
var weekSpacing = 85

signal updateDay

func _ready():
	
	for i in range(-weekNum,weekNum+1):
		var week = Week.instance()
		add_child(week)
		week.set_position(Vector2(-300,weekSpacing*i+500))
		week.weekNum = i;
	
	pass
	
func _on_Timer_timeout():
	emit_signal("updateDay")
