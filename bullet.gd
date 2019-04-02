extends Node2D

var dir = Vector2(0,-1)
export var speed = 10

func _process(delta):
	var velocity = Vector2(1, 0).rotated(rotation - PI / 2)
	position += velocity * speed
