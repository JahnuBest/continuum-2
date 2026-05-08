extends Node2D

@export var bullet_data : BulletData
var team : int

func set_data(bullet_data, position, rotation, velocity, team) -> void:
	$BulletBody.bounces = bullet_data.bounces
	self.bullet_data = bullet_data
	$BulletBody/BulletShape.color = bullet_data.color
	self.position = position
	self.rotation = rotation
	$BulletBody.velocity = velocity
	self.team = team

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.team != team:
		print("bullet from team " + str(team) + " collided with team 0")
		queue_free()
