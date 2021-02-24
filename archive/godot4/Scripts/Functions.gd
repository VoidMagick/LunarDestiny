extends Node

var yearChunk = [366,365,365,365]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func DayNumFromDate(year,month,day):
	var DayNum = 0
	var MList = 0
	var leapyear = true
	
	if leapyear:
		MList = [0,31,59,90,120,151,181,212,243,273,304,334]
	else:
		MList = [0,31,60,91,121,152,182,213,244,274,305,335]
	
	#DayNum = year-2000 + MList(month) + day
	
	return(DayNum)

func WeekFromDay(daynum):
	return((daynum + 700005)/7 - 100000) # large number buffer to keep integer calcs positive

func SundayFromWeek(week):
	var year = 0
	var month = 0
	var day = 0
	
	var DayNum = week * 7 - 5
	
	year = 2000 + (week+52000-1)/52
	
	return([year,month,day])


