extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$NameTag.position = $ShipBody.position + Vector2(15,0)
	if $ShipBody.flags > 0:
		if $NameTag.get_theme_color("font_color") != Color.RED: $NameTag.add_theme_color_override("font_color", Color.RED)
	else:
		if $NameTag.get_theme_color("font_color") != Color.WHITE: $NameTag.add_theme_color_override("font_color", Color.WHITE)
