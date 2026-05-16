extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()

func _on_animation_finished() -> void:
	queue_free()
