extends CharacterBody2D

var max_boost_velocity = 400
var max_normal_velocity = 200
var max_velocity = 200

var normal_accel = 200
var boost_accel = 400
var accel = 200

var decel = 50
var turn_speed = 3.0

var max_health = 1200
var base_health = 1200
var health = 1200
var health_recharge_rate = 50
var health_boost_discharge_rate = 200

var flags := 0
var team = 0

var Bullet := preload("res://bullet.tscn")
# TODO: Export this later?
var current_bullet_data := preload("res://bulletData/default_bullet.tres")
var current_bomb_data := preload("res://bulletData/default_bomb.tres")
var current_mine_data := preload("res://bulletData/default_mine.tres")

func _physics_process(delta: float) -> void:
	# Special buttons check
	if Input.is_action_just_pressed("shipwarp"):
		# TODO: Should be a random spot in safe zone
		position = Vector2(0,0)
	
	if Input.is_action_pressed("left"): rotation -= turn_speed * delta
	elif Input.is_action_pressed("right"): rotation += turn_speed * delta
	
	if Input.is_action_pressed("boost"):
		max_velocity = max_boost_velocity
		accel = boost_accel
		health = max(health - health_boost_discharge_rate * delta, 0)
	else:
		max_velocity = max_normal_velocity
		health = min(health + health_recharge_rate * delta, max_health)
		accel = normal_accel
	
	if velocity.x > max_velocity or velocity.y > max_velocity:
		velocity = velocity.move_toward(Vector2.ZERO, decel * delta * 4)
		
	if Input.is_action_pressed("forward"):
		velocity = velocity.move_toward(Vector2.UP.rotated(rotation) * max_velocity, accel * delta)
	elif Input.is_action_pressed("backward"):
		velocity = velocity.move_toward(Vector2.UP.rotated(rotation) * -max_velocity, accel * delta)
	else: velocity = velocity.move_toward(Vector2.ZERO, decel * delta)
	#position += velocity * delta
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: 
		var collider = collision_info.get_collider()
		if collider.collision_layer == 4:		# Flags
			flags += 1
			collision_info.get_collider().queue_free()
			health = min(base_health + 100, health + 100)
			max_health = base_health + (flags * 100)
		elif collider.collision_layer == 2:		# Walls
			velocity = velocity.bounce(collision_info.get_normal())
			
	# Shoot checks
	if Input.is_action_just_pressed("mine"):
		shoot(current_mine_data, false)
	
	elif Input.is_action_just_pressed("bullet"):
		shoot(current_bullet_data)
	
	elif Input.is_action_just_pressed("bomb"):
		shoot(current_bomb_data)	

func shoot(bullet_data:BulletData, use_ship_momentum:=true) -> void:
	#print("spawned bullet")
	var spawned_bullet = Bullet.instantiate()
	var bullet_velocity = Vector2.UP.rotated(rotation) * bullet_data.speed
	if use_ship_momentum: bullet_velocity += velocity
	spawned_bullet.set_data(bullet_data, position, rotation, bullet_velocity, team)
	get_parent().add_child(spawned_bullet)
