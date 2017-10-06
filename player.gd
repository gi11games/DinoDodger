extends KinematicBody2D

const ACCEL = 500 		#How fast player accelerates when a key is pressed
const MAX_SPEED = 100	#The maximum speed 
const FRICTION = -1000	#How quickly player comes to a stop
const GRAVITY = 500	#Gravity player is effected by

const JUMP_SPEED = 200
const JUMP_MAX_AIRBORNE_TIME = 0.2

var acc = Vector2() 	#Store movement
var vel = Vector2()		#Store movement

#jump variables
var on_air_time = 100
var jumping = false
var prev_jump_pressed = false

func _ready():
	pass

func _physics_process(delta):
	acc.y = GRAVITY
	#acc.x = Input.is_action_pressed("move_right") - Input.is_action_pressed("move_left")

	acc.x = 0
	if Input.is_action_pressed("move_right"):
		acc.x = 1
		get_node("sprite").set_flip_h(false)
	if Input.is_action_pressed("move_left"):
		acc.x = -1
		get_node("sprite").set_flip_h(true)
	var jump = Input.is_action_pressed("jump")
	
	if acc.x == 0:
		get_node("sprite").play("idle")
	else:
		get_node("sprite").play("run")
	
	#Multiple direction value by ACCEL to get the correct magnitude and apply it to Velocity
	#If direction is 0, then apply friction to slow down and stop the player
	#Clamp player speed between max_speed
	acc.x *= ACCEL
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta
	vel += acc * delta
	vel.x = clamp(vel.x, - MAX_SPEED, MAX_SPEED)
	var move = move_and_slide(vel, Vector2(0,-1))
	#The second argument in move_and_slide lets you determine where the FLOOR.
	
	
	#Jumping
	if (is_on_floor()): on_air_time = 0
	
	if (jumping and vel.y > 0): jumping = false
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		vel.y = -JUMP_SPEED
		jumping = true
		
	on_air_time += delta
	prev_jump_pressed = jump
	
	var pos = get_position()
	
	pos.x = clamp(pos.x, 8, get_viewport_rect().size.x - 6)
	set_position(pos)

func hitByDino():
	queue_free()
	
	get_tree().reload_current_scene()