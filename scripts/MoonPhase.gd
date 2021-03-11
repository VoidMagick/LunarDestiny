extends Node

## Duration of lunar cycle in days
const lunarDays = 29.53058770576

## Duration of lunar cycle in seconds
const lunarSeconds = lunarDays * (24 * 60 * 60)

## Unixtime of first full moon in 2000 (Jan 6th at 6:14pm)
var dateTime = {"year": 2000, "month": 1, "day": 6, "hour": 18, "minute": 14, "second": 0}
var new2000 = OS.get_unix_time_from_datetime(dateTime)


func _ready():
	calculate_moon_phases_2021()

## Calculate moon cycles for every day in 2021
func calculate_moon_phases_2021():
	
	## Unix time at start	
	var startTime = OS.get_unix_time_from_datetime(
		{
			"year": 2021,
			"month": 1,
			"day": 1,
			"hour": 0,
			"minute": 0,
			"second": 0
			}
	)

	## Unix time at end	
	var endTime = OS.get_unix_time_from_datetime(
		{
			"year": 2021,
			"month": 12,
			"day": 31,
			"hour": 23,
			"minute": 59,
			"second": 59
			}
	)
	
	## Calculate for every 24 hours	
	var incrementTime = 24*60*60
	
	## Preallocate for speed lols
	var elapsedTime
	var currentSeconds
	var currentFraction
	var currentDays
	
	## Iterate and Calculate
	for unixTime in range(startTime,endTime,incrementTime):
		elapsedTime = unixTime - new2000
		currentSeconds = fmod(elapsedTime,lunarSeconds)
		currentFraction =  currentSeconds / lunarSeconds
		currentDays = currentFraction * lunarDays
		var dicTime = OS.get_datetime_from_unix_time(unixTime)
		#print("Unixtime: ",unixTime,"; currentFraction: ",currentFraction)
		#print(dicTime.year,"-",dicTime.month,"-",dicTime.day,"; currentFraction: ",currentFraction)
