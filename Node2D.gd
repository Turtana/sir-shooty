extends Node2D

export (PackedScene) var Bullet
export var speed = 300

var can_shoot = true
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed("ui_shoot") and can_shoot:
		var fire = Bullet.instance()
		var mpos = get_viewport().get_mouse_position()
		add_child(fire)
		fire.rotation = position.angle_to_point(mpos) - PI / 2
		can_shoot = false
		$FireDelay.start()

func _on_FireDelay_timeout():
	can_shoot = true
