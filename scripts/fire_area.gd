extends Node2D

export var radius = 300
export var lines = 100
export var fov = PI / 3
export var dir = PI / 2

var origo = Vector2(0,0)
	
func _process(delta):
	update()

func _draw():
	for i in range(lines + 1):
		var angle = dir - fov / 2 + i * (fov / lines)
		var dist = Vector2(origo.x + radius * sin(angle), origo.y + radius * cos(angle))
		
		var ray = RayCast2D.new()
		ray.set_cast_to(dist)
		add_child(ray)
		
		ray.force_raycast_update()
		if ray.is_colliding():
			dist = ray.get_collision_point() - to_global(position)
		
		draw_line(origo, dist, Color.yellow, 2.0)