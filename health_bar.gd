extends ColorRect

var max_width := 400 # Should be proportional to screen width

func set_health_bar_width(current_health: int, max_health: int):
	var percent := current_health * 1.0 / max_health
	size.x = max_width * percent
	color = Color(1.0 - percent, percent, 0)
	offset_left = -size.x/2
	offset_right = size.x/2
