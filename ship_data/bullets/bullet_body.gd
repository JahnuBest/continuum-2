extends CharacterBody2D

var bounces : int

func _ready() -> void:
	# Assume that bullet_data has been initialized.
	pass

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.collision_layer == 2:
			bounces -= 1
			if bounces <= 0: get_parent().queue_free()
			else: 
				velocity = velocity.bounce(collision_info.get_normal())
				rotation = velocity.angle() + PI/2
		elif collider.collision_layer == 1:
			pass
