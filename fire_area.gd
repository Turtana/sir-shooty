extends Node2D

export var radius = 300
export var lines = 50
export var fov = PI / 2
export var dir = PI / 2

var origo = Vector2(0,0)

func _ready():
	print(position)
	
func _process(delta):
	dir = 3 * PI / 2 - position.angle_to_point(get_viewport().get_mouse_position())
	update()

func _draw():
	for i in range(lines + 1):
		var angle = dir - fov / 2 + i * (fov / lines)
		var dist = Vector2(origo.x + radius * sin(angle), origo.y + radius * cos(angle))
#		dist = Vector2(origo.x + i, origo.y - i)
		draw_line(origo, dist, Color.yellow)