extends Camera2D

var panSpeed = 6
var scrollSpeed = 0.2
var minZoom = 1
var maxZoom = 3

func _ready():
	set_process_input(true)

func _process(_delta):	
	if Input.is_action_pressed("ui_up"):
		_pan_camera_vertical(-panSpeed)	
	if Input.is_action_pressed("ui_down"):
		_pan_camera_vertical(panSpeed)

func _input(event):
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		if event.pressed:
			match event.button_index:
				BUTTON_WHEEL_UP:
					_zoom_camera(-scrollSpeed)
				BUTTON_WHEEL_DOWN:
					_zoom_camera(scrollSpeed)

func _pan_camera_vertical(distance):
	var currentOffset = get_offset()
	set_offset(Vector2(currentOffset.x,currentOffset.y+distance))

func _zoom_camera(distance):
	var currentZoom = get_zoom()
	var newZoom = Vector2(currentZoom.x+distance,currentZoom.y+distance)
	if newZoom.x <= minZoom:
		newZoom = Vector2(minZoom,minZoom)
	elif newZoom.x >= maxZoom:
		newZoom = Vector2(maxZoom,maxZoom)
	set_zoom(newZoom)
