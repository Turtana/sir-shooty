extends Area2D

export var speed = 1000

func _process(delta):
	var velocity = Vector2(1, 0).rotated(rotation - PI / 2)
	position += velocity * speed * delta

func _on_Timer_timeout():
	get_parent().remove_child(self)

func _on_Bullet_body_entered(body):
	queue_free()
