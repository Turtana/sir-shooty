extends Area2D

export var speed = 500
export var damage = 15
export (PackedScene) var spark

func _process(delta):
	var velocity = Vector2(1, 0).rotated(rotation - PI / 2)
	position += velocity * speed * delta

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(_body):
	if _body.get("id") == "enemy":
		_body.damage(damage)
	
	var sparky = spark.instance()
	sparky.position = position
	get_parent().add_child(sparky)
	queue_free()