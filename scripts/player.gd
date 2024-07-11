extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300
var start_position = Vector2(100, 0)
const RESPAWN_PLANE = 3500.0
var x_pos_to_spawn = 500
var x_pos_scalar = 2000
signal need_more_tiles

var tile = preload("res://tile.tscn")

func respawn():
	global_position = start_position

func check_respawn():
	if global_position.y > RESPAWN_PLANE:
		respawn()

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if  velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y =  -jump_force
		
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = 300 * horizontal_direction
	move_and_slide()
	check_respawn()
	check_distance()
	
	

func flame_reached():
	emit_signal("resaturate")
	print("Flame Reached")
	
func check_distance():
	if global_position.x > x_pos_to_spawn:
		distance_more_tiles_needed()

func distance_more_tiles_needed():
	x_pos_to_spawn += x_pos_scalar
	emit_signal("need_more_tiles")
