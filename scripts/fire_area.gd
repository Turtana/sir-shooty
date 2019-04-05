extends Node2D

export var radius = 300
export var lines = 50
export var fov = 60
export var dir = PI / 2
export var enabled = false

var origo = Vector2(0,0)
var enemy
var line_rays

func _enter_tree():
	fov = fov * (PI / 180)
	line_rays = lines + 1
	pass

func _process(_delta):
	update()

func _draw():
	if (enabled):
		var points = [origo]
		var rays_into_enemy = 0
		for i in range(line_rays):
			var angle = dir - fov / 2 + i * (fov / lines)
			var dist = Vector2(origo.x + radius * sin(angle), origo.y + radius * cos(angle))
			
			var ray = RayCast2D.new()
			ray.set_cast_to(dist)
			add_child(ray)
			
			ray.force_raycast_update()
			if ray.is_colliding():
				if ray.get_collider().get("id") == "enemy":
					enemy = ray.get_collider()
					rays_into_enemy += 1
				else:
					dist = ray.get_collision_point() - to_global(position)
			
			points.push_front(dist)
		if (rays_into_enemy > 0):
			enemy.set_hit_chance(float(rays_into_enemy) / (line_rays))
			pass
		else:
			if (enemy):
				enemy.set_hit_chance(0) # Set the chance to 0 after moving the zone out
				enemy = null
		draw_polygon(points, PoolColorArray([Color(1, 1, 0, 0.5)]))