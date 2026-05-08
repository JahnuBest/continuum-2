extends StaticBody2D

@export var health_boost : int
@export var damage_boost : int

func _ready() -> void:
	$AnimatedSprite2D.play()
