extends Node2D

export var camera_speed = 10

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		$Camera.position.y += camera_speed
	if Input.is_action_pressed("ui_up") and $Camera.position.y > 0:
		$Camera.position.y -= camera_speed
	if Input.is_action_pressed("ui_left") and $Camera.position.x > 0:
		$Camera.position.x -= camera_speed
	if Input.is_action_pressed("ui_right"):
		$Camera.position.x += camera_speed

func _on_HUD_change_mode():
	$Player.change_mode()

func _on_HUD_only_hud_input():
	$Player.hold_control = !$Player.hold_control
