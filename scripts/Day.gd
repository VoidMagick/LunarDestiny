extends Control

export var dayNum = 0
export var dayRelative = 0

var monthColor = [
	Color(0.925, 0.353, 0.475),	# Jan
	Color(0.502, 0.349, 0.545),	# Feb
	Color(0.275, 0.502, 0.651),	# Mar
	Color(0.345, 0.894, 0.890),	# Apr
	Color(0.400, 0.729, 0.322),	# May
	Color(0.294, 0.510, 0.333),	# Jun
	Color(0.580, 0.847, 0.463),	# Jul
	Color(0.851, 0.824, 0.502),	# Aug
	Color(0.976, 0.808, 0.271),	# Sep
	Color(0.780, 0.565, 0.290),	# Oct
	Color(0.612, 0.357, 0.251),	# Nov
	Color(0.620, 0.176, 0.231),	# Dec
]

var astroColor= [
	Color(0.859, 0.102, 0.165),	# Aries
	Color(0.737, 0.271, 0.184),	# Taurus
	Color(0.141, 0.596, 0.114),	# Gemini
	Color(0.294, 0.600, 0.643),	# Cancer
	Color(0.976, 0.792, 0.165),	# Leo
	Color(0.145, 0.384, 0.247),	# Virgo
	Color(0.059, 0.067, 0.247),	# Libra
	Color(0.396, 0.125, 0.204),	# Scorpio
	Color(0.965, 0.380, 0.063),	# Sagittarius
	Color(0.184, 0.192, 0.494),	# Capricorn
	Color(0.408, 0.212, 0.592),	# Aquarius
	Color(0.969, 0.173, 0.690),	# Pisces
]

func _ready():
	var Calendar = get_tree().get_root().find_node("Calendar",true,false)
	Calendar.connect("updateDay",self,"_update")
	
func _process(_delta):
#	_draw_day()
	pass
	
func _physics_process(delta):
#	_draw_day()
	pass
	
func _update():
	_draw_day()
	pass
	
func _draw_day():
	
	var dayOffset = dayRelative
	
	var month = _get_day_month(dayOffset)
	
	$Debug/LYEAR.text = _get_day_year(dayOffset)
	$Debug/LMONTH.text = month
	$Debug/LDAY.text = _get_day_day(dayOffset)
	$Debug/LRDAY.text = str(dayRelative)
	
	var moonPercent = _get_moon_percent(dayOffset)
	$Debug/LMOON.text = str(moonPercent)
	
	var c = moonPercent
	$Background.color = Color(c,c,c)
	
	var astroSign = _get_astro_sign(dayOffset)
	$Background.color = astroColor[astroSign-1]
	
	var month_int = int(month)-1
	$Background.color = monthColor[month_int]
	
	if dayOffset == 0:
		$Panel.self_modulate = Color(1,1,1,0.8)

func _get_day_year(offset):
	var unixTime = OS.get_unix_time()
	var timeZone = OS.get_time_zone_info()
	unixTime = unixTime + offset * 60 * 60 * 24 + timeZone.bias * 60
	var dayDict = OS.get_datetime_from_unix_time(unixTime)
	return(str(dayDict.year))

func _get_day_month(offset):
	var unixTime = OS.get_unix_time()
	var timeZone = OS.get_time_zone_info()
	unixTime = unixTime + offset * 60 * 60 * 24 + timeZone.bias * 60
	var dayDict = OS.get_datetime_from_unix_time(unixTime)
	return(str(dayDict.month))

func _get_day_day(offset):
	var unixTime = OS.get_unix_time()
	var timeZone = OS.get_time_zone_info()
	unixTime = unixTime + offset * 60 * 60 * 24 + timeZone.bias * 60
	var dayDict = OS.get_datetime_from_unix_time(unixTime)
	return(str(dayDict.day))

func _get_moon_percent(offset):
	
	## Duration of lunar cycle in days
	var lunarDays = 29.53058770576
	
	## Duration of lunar cycle in seconds
	var lunarSeconds = lunarDays * (24 * 60 * 60)

	## Unixtime of first full moon in 2000 (Jan 6th at 6:14pm UTC)
	var dateTime = {"year": 2000, "month": 1, "day": 6, "hour": 18, "minute": 14, "second": 0}
	var new2000 = OS.get_unix_time_from_datetime(dateTime)
	
	## Number of unix seconds since baseline full moon
	var unixTime = OS.get_unix_time()
	var timeZone = OS.get_time_zone_info()
	unixTime = unixTime + offset * 60 * 60 * 24 + timeZone.bias * 60
	var elapsedTime = unixTime - new2000
	
	var moonPercent = -0.5*cos((2*PI*elapsedTime)/lunarSeconds)+0.5
	
	return moonPercent

func _get_astro_sign(offset):
	
	var unixTime = OS.get_unix_time()
	var timeZone = OS.get_time_zone_info()
	unixTime = unixTime + offset * 60 * 60 * 24 + timeZone.bias * 60
	var dayDict = OS.get_datetime_from_unix_time(unixTime)
	
	if dayDict.month == 1:
		if dayDict.day <= 20:
			return 10
		else:
			return 11
			
	elif dayDict.month == 2:
		if dayDict.day <= 19:
			return 11
		else:
			return 12
			
	elif dayDict.month == 3:
		if dayDict.day <= 20:
			return 12
		else:
			return 1
			
	elif dayDict.month == 4:
		if dayDict.day <= 20:
			return 1
		else:
			return 2
			
	elif dayDict.month == 5:
		if dayDict.day <= 21:
			return 2
		else:
			return 3
			
	elif dayDict.month == 6:
		if dayDict.day <= 21:
			return 3
		else:
			return 4
			
	elif dayDict.month == 7:
		if dayDict.day <= 22:
			return 4
		else:
			return 5
			
	elif dayDict.month == 8:
		if dayDict.day <= 22:
			return 5
		else:
			return 6
			
	elif dayDict.month == 9:
		if dayDict.day <= 23:
			return 6
		else:
			return 7
			
	elif dayDict.month == 10:
		if dayDict.day <= 23:
			return 7
		else:
			return 8
			
	elif dayDict.month == 11:
		if dayDict.day <= 22:
			return 8
		else:
			return 9
			
	elif dayDict.month == 12:
		if dayDict.day <= 22:
			return 9
		else:
			return 10
	
	
	
	
	
	
	
	
	
	
	

