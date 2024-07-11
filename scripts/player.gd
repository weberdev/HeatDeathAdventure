extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300
var start_position = Vector2(100, 0)
const RESPAWN_PLANE = 3500.0

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
	

func flame_reached():
	emit_signal("resaturate")
	print("Flame Reached")
