extends KinematicBody2D

export var id = "enemy"
export var rays_into_enemy = 0
export var hit_chance = 0
export var health = 100
export var alive = true

var dead_img = preload("res://art/enemy_dead.png")

func _ready():
	$HealthBar.value = health

func set_hit_chance(chance):
	if (chance == 0):
		$HitChanceLabel.text = ""
		hit_chance = 0
	else:
		$HitChanceLabel.text = str(round(chance * 100)) + " %"
		hit_chance = round(chance * 100)

func damage(dmg):
	if health - dmg > 0:
		health -= dmg
	else:
		health = 0
		queue_free()
	$HealthBar.value = health

func die():
	$HealthBar.visible = false
	$Sprite.texture = dead_img
	alive = false