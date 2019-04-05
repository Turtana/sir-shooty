extends KinematicBody2D

export var id = "enemy"

func _ready():
	pass

func set_hit_chance(chance):
	if (chance == 0):
		$HitChance.text = ""
	else:
		$HitChance.text = str(round(chance * 100)) + " %"