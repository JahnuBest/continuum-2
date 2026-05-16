extends ColorRect

var max_width := 400 # TODO: Should be proportional to screen width
var displayed_health := 0.0

func set_health_bar_width(current_health: int, max_health: int, delta):
	#if displayed_health == 0: displayed_health = current_health
	#displayed_health = lerp(displayed_health, current_health * 1.0, 10 * delta)
	var percent := current_health * 1.0 / max_health
	size.x = max_width * percent
	color = Color(1.0 - percent, percent, 0)
	offset_left = -size.x/2
	offset_right = size.x/2
