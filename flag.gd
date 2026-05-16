extends StaticBody2D

@export var health_boost : int
@export var damage_boost : int

func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()
