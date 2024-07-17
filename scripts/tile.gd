extends StaticBody2D

@export var tile_images = [
	preload("res://assets/BadTile1.png"), 
	preload("res://assets/BadTile2.png"),
	preload("res://assets/BadTile3.png"),
	preload("res://assets/NeutralTile1.png"),
	preload("res://assets/NeutralTile2.png"),
	preload("res://assets/NeutralTile3.png"),
	preload("res://assets/NeutralTile4.png"),
	preload("res://assets/NeutralTile5.png"),
	preload("res://assets/NeutralTile6.png"),   
	preload("res://assets/NeutralTile7.png")
]

var rng = RandomNumberGenerator.new()

func _ready():
	var sprite = $Sprite
	var random_index = rng.randi_range(0, tile_images.size() - 1)
	var random_texture = tile_images[random_index]
	sprite.texture = random_texture


func _process(delta):
	pass
