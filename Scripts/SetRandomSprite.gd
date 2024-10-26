extends Sprite2D

@export var sprites : Array[Texture2D]
@onready var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()
	sprites.append(texture)
	var index = random.randi_range(0, len(sprites) -1)
	texture = sprites[index]
