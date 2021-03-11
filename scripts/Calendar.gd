extends Panel

var Week = preload("res://Week.tscn")

var weekNum = 20
var weekSpacing = 85

func _ready():
	
	for i in range(-weekNum,weekNum+1):
		var week = Week.instance()
		add_child(week)
		week.set_position(Vector2(5,weekSpacing*i+500))
		week.weekNum = i;
	
	pass
