extends Line2D

export(NodePath) var targetPath
var target
var point
var launchReady = false
var signalNotEmit = false

var numberOfPoints = 0

signal launchedSet

func _ready():
	target = get_node(targetPath)
	global_position = Vector2(0, 0)
	global_rotation = 0
	point = target.global_position
	add_point(point)

func _process(delta):
	numberOfPoints = get_point_count()
	global_position = Vector2(0, 0)
	global_rotation = 0
	point = target.global_position
	set_point_position(0, point)
	
	if launchReady == true and signalNotEmit == false:
		signalNotEmit = true
		emit_signal("launchedSet")
	

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		if numberOfPoints == 1:
			add_point(event.global_position)
			launchReady = true
			signalNotEmit = false
		else:
			set_point_position(1, event.global_position)
			launchReady = true
			print("MOVEMENT MOUSE: " + str(event.global_position))
	elif not Input.is_mouse_button_pressed(BUTTON_LEFT):
		if numberOfPoints == 2:
			remove_point(1)
			launchReady = false
