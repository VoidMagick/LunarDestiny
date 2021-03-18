extends Camera2D

var panSpeed = 6
var scrollSpeed = 0.2
var MIN_ZOOM = 1
var MAX_ZOOM = 3

func _ready():
	set_process_input(true)

func _process(_delta):	
	if Input.is_action_pressed("ui_up"):
		_pan_camera_vertical(-panSpeed)	
	if Input.is_action_pressed("ui_down"):
		_pan_camera_vertical(panSpeed)

func _input(event):
	if event is InputEventMouseButton:
#		event as InputEventMouseButton
		if event.pressed:
			match event.button_index:
				BUTTON_WHEEL_UP:
					_zoom_camera(-scrollSpeed)
				BUTTON_WHEEL_DOWN:
					_zoom_camera(scrollSpeed)
	elif event is InputEventSingleScreenDrag:
		_gesture_move(event)
	elif event is InputEventScreenPinch:
		_gesture_zoom(event)

func _pan_camera_vertical(distance):
	var currentOffset = get_offset()
	set_offset(Vector2(currentOffset.x,currentOffset.y+distance))

func _zoom_camera(distance):
	var currentZoom = get_zoom()
	var newZoom = Vector2(currentZoom.x+distance,currentZoom.y+distance)
	if newZoom.x <= MIN_ZOOM:
		newZoom = Vector2(MIN_ZOOM,MIN_ZOOM)
	elif newZoom.x >= MAX_ZOOM:
		newZoom = Vector2(MAX_ZOOM,MAX_ZOOM)
	set_zoom(newZoom)

func _gesture_move(event):
	position -= Vector2(0,(event.relative*zoom).rotated(rotation).y)

func _gesture_zoom(event):
	var li = event.distance
	var lf = event.distance + event.relative
	var zi = zoom.x
	
	var zf = (li*zi)/lf
	if zf == 0: return
	var zd = zf - zi
	
	if zf <= MIN_ZOOM and sign(zd) < 0:
		zf =MIN_ZOOM
		zd = zf - zi
	elif zf >= MAX_ZOOM and sign(zd) > 0:
		zf = MAX_ZOOM
		zd = zf - zi
