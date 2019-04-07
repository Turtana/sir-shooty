extends Node2D

export var radius = 300
export var lines = 50
export var fov = 60
export var dir = PI / 2
export var enabled = false

var origo = Vector2(0,0)
var enemies
var line_rays

func _enter_tree():
	fov = fov * (PI / 180)
	line_rays = lines + 1
	enemies = []

func _process(_delta):
	update()

func _draw():
	var old_enemies = []
	if (enabled):
		old_enemies = enemies
		enemies = []
		var points = [origo]
		
		for i in range(line_rays):
			var angle = dir - fov / 2 + i * (fov / lines)
			var dest = Vector2(origo.x + radius * sin(angle), origo.y + radius * cos(angle))
			
			var ray = RayCast2D.new()
			ray.set_cast_to(dest)
			add_child(ray)
			
			ray.force_raycast_update()
			if ray.is_colliding():
				var other = ray.get_collider()
				if other.get("id") == "enemy":
					var enemy = other
					if enemies.find(enemy) == -1:
						enemy.set("rays_into_enemy", 0)
						enemies.push_back(enemy)
					enemy.set("rays_into_enemy", enemy.get("rays_into_enemy") + 1)
				dest = ray.get_collision_point() - to_global(position)
			points.push_front(dest)
		
		for old_enemy in old_enemies:
			var wr = weakref(old_enemy)
			
			if !wr.get_ref():
				old_enemies.erase(old_enemy)
				continue
			if enemies.find(old_enemy) == -1:
				old_enemy.set_hit_chance(0)
				old_enemies.erase(old_enemy)
		
		for enemy in enemies:
			var hit_rays = enemy.get("rays_into_enemy")
			enemy.set_hit_chance(float(hit_rays) / (line_rays))
		draw_polygon(points, PoolColorArray([Color(1, 1, 0, 0.5)]))
	else: # disabled
		for old_enemy in enemies:
			old_enemy.set_hit_chance(0)
			enemies.erase(old_enemy)