extends Area2D

signal flame_reached

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_arrived_at_flame"))

# Function to handle the arrival at the flame
func _arrived_at_flame(body):
	if body.name == "playericon":
		emit_signal("flame_reached")
