extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	play()

func _on_animation_finished() -> void:
	queue_free()
