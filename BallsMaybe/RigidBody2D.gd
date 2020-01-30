extends Area2D

export var mass = 5.0
const speed = 5
var shoot = false
var detect = false
var velocity = Vector2(0, 0)
var mouseMotion = false
var ready = false

onready var imageSpr = $Sprite

func _process(delta):
	if shoot:
		velocity += gravity_vec*gravity*mass*delta
		global_position += velocity*delta
		if not mouseMotion:
			global_rotation = velocity.angle()

func _input(event):
	if Input.is_action_just_released("BUTTON_LEFT") and ready:
		imageSpr.set_flip_h(false)
		imageSpr.set_flip_v(false)
		mouseMotion = false
		var mousePos = get_global_mouse_position()
		var posDiff = mousePos - global_position
		launched(-posDiff*speed)
		detect = true
	
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var mousePos = get_global_mouse_position()
		var posDiff = mousePos - global_position
		imageSpr.set_flip_h(true)
		imageSpr.set_flip_v(true)
		mouseMotion = true
		global_rotation = posDiff.angle()
		print("MOUSE HELD: " + str(mousePos))
	
	if Input.is_action_just_pressed("ui_end"):
		get_tree().reload_current_scene()

func launched(initial_velocity : Vector2):
	shoot = true
	velocity = initial_velocity

func _on_Ball_body_entered(body):
	if body.collides == true and detect:
		velocity = Vector2(0, 0)
		shoot = false
		detect = false


func _on_Trail_launchedSet():
	ready = true
