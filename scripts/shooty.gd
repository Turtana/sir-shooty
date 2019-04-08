extends KinematicBody2D

export (PackedScene) var Bullet
export var speed = 300
export var fov = 60
export var hold_control = true

var screen_size
var mode
var move_to_coords
var last_position

func _ready():
	fov = fov * (PI / 180)
	$FireArea.fov = fov
	screen_size = get_viewport_rect().size
	mode = "move" # "shoot" and "move"
	move_to_coords = position

func _process(_delta):
	last_position = position
	if ((position - move_to_coords).length() > 5 and mode == "move"):
		var velocity = Vector2(-1, 0)
		velocity = velocity.rotated(position.angle_to_point(move_to_coords))
#warning-ignore:return_value_discarded
		move_and_slide(velocity * speed)
	
	if last_position == position and move_to_coords != position:
		print("Blocked")
		move_to_coords = position
	
	if mode == "shoot":
		$FireArea.enabled = true
		$FireArea.dir = 3 * PI / 2 - position.angle_to_point(get_global_mouse_position())
	else:
		$FireArea.enabled = false

func _input(event):
	if hold_control:
		return
	if event.is_action_pressed("ui_click"):
		if mode == "shoot":
			shoot()
		if mode == "move":
			move()

func change_mode():
	if mode == "shoot":
		mode = "move"
	elif mode == "move":
		mode = "shoot"

func move():
	move_to_coords = get_global_mouse_position()
	print("Moving to ", move_to_coords)


func burst(amount):
	for _i in range(amount):
		shoot()
		yield(get_tree().create_timer(.2), "timeout")

func shotgun(amount):
	for _i in range(amount):
		shoot()

func shoot():
	var fire = Bullet.instance()
	var mpos = get_global_mouse_position()
	get_parent().add_child(fire)
	fire.position = position
	fire.rotation = (position.angle_to_point(mpos) - PI / 2) + rand_range(-fov / 2, fov / 2)
	$PewSound.play()