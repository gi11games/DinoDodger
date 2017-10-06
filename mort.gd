extends KinematicBody2D

var viewsize = Vector2()
var startPos = Vector2()
var speed = 1

func _ready():
	randomize()
	viewsize = get_viewport_rect().size
	startPos.x = rand_range(8, viewsize.x-8)
	startPos.y = -16
	speed = int(rand_range(1, 4))
	set_position(startPos)
	
func _physics_process(delta):
	var move = move_and_collide(Vector2(0, speed))
	
	if (move != null): 
		if (move.get_collider().is_in_group("player")):
			get_node("/root/main/player").hitByDino()
		elif (move.get_collider().is_in_group("dino")):
			pass
		else:
			queue_free()