extends Control

var button_shoot = preload("res://art/ui_shoot.png")
var button_move = preload("res://art/ui_move.png")

signal change_mode
signal only_hud_input

func _process(_delta):
	$FpsCounter.text = String(Engine.get_frames_per_second())

func _on_ModeButton_pressed():
	if $ModeButton.icon == button_move:
		$ModeButton.icon = button_shoot
	else:
		$ModeButton.icon = button_move
	emit_signal("change_mode")

func _on_HUD_mouse_exited():
	emit_signal("only_hud_input")

func _on_HUD_mouse_entered():
	emit_signal("only_hud_input")
