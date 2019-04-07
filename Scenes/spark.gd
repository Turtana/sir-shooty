extends Sprite

func _ready():
	rotate(rand_range(0,PI))
	$AnimationPlayer.play("spark")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
