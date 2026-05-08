extends Node2D

@onready var ui := $MainCamera/MainUI
@onready var velocityLabel = ui.get_node("VelocityLabel")
@onready var healthLabel = ui.get_node("HealthLabel")
@onready var positionLabel = ui.get_node("PositionLabel")
@onready var healthBar = ui.get_node("HealthBar")
@onready var fpsLabel = ui.get_node("FPSLabel")

@export var test_weapons_scene: PackedScene

var current_bullet_data := preload("res://bulletData/default_bullet.tres")
var current_bomb_data := preload("res://bulletData/default_bomb.tres")
var current_mine_data := preload("res://bulletData/default_mine.tres")

func _ready() -> void:
	return
	$TestWeapons/TestWeaponsTimer.start()


func _process(delta: float) -> void:
	var ui = $MainCamera/MainUI
	$MainCamera.position = $Ship.position + $Ship/ShipBody.position
	velocityLabel.text = "Velocity: " + str(Vector2i($Ship/ShipBody.velocity))
	healthLabel.text = str(int($Ship/ShipBody.health))
	fpsLabel.text = "FPS: " + str(int(Performance.get_monitor(Performance.TIME_FPS)))
	positionLabel.text = "Position: " + str(Vector2i($Ship/ShipBody.position))
	healthBar.set_health_bar_width($Ship/ShipBody.health, $Ship/ShipBody.max_health)


func _on_test_weapons_timer_timeout() -> void:
	return
	var weapon = test_weapons_scene.instantiate()
	var random_bullet_res = [current_bullet_data, current_bomb_data]
	random_bullet_res = random_bullet_res.pick_random()
	var weapon_spawn = $TestWeapons/TestWeaponsLocation
	weapon_spawn.progress_ratio = randf()
	#weapon.position = weapon_spawn.position
	var direction = weapon_spawn.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	var velocity = Vector2(randf_range(200.0, 400.0), 0.0)
	weapon.set_data(random_bullet_res, weapon_spawn.position, direction, velocity, 1)
	add_child(weapon)
	$TestWeapons/TestWeaponsTimer.start()
	"""
	var weapon = test_weapons_scene.instantiate()
	weapon.bullet_data = bullet_data
	weapon.set_bullet_data()
	weapon.position = position
	weapon.rotation = rotation
	weapon.velocity = 
	get_parent().add_child(weapon)
	"""
