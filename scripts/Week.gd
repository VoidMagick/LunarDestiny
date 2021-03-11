extends HBoxContainer

export var weekNum = 0

var Red = Color(1,0,0)
var Green = Color(0,1,0)
var Blue = Color(0,0,1)

var weekSpread = PoolIntArray(range(0,7))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):	
	_run_week()

func _run_week():
	
	## Initialize day values
	$Day0.dayRelative = 0
	$Day1.dayRelative = 1
	$Day2.dayRelative = 2
	$Day3.dayRelative = 3
	$Day4.dayRelative = 4
	$Day5.dayRelative = 5
	$Day6.dayRelative = 6
	
	## Adjust day values per week

	$Day0.dayRelative = $Day0.dayRelative + 7 * weekNum
	$Day1.dayRelative = $Day1.dayRelative + 7 * weekNum
	$Day2.dayRelative = $Day2.dayRelative + 7 * weekNum
	$Day3.dayRelative = $Day3.dayRelative + 7 * weekNum
	$Day4.dayRelative = $Day4.dayRelative + 7 * weekNum
	$Day5.dayRelative = $Day5.dayRelative + 7 * weekNum
	$Day6.dayRelative = $Day6.dayRelative + 7 * weekNum
	
	var currentDay = OS.get_date()
	
	var dayArray = [$Day0, $Day1, $Day2, $Day3, $Day4, $Day5, $Day6]
	
	if weekNum == 0:
		dayArray[currentDay.weekday].color = Red
	
	for Day in dayArray:
		Day.dayRelative = Day.dayRelative - currentDay.weekday
