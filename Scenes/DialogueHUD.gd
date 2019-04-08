extends Control

export var opening = "Lorem ipsum dolor sit amen test test test. What do you want, human?"

var options = ["Hello fellow alien.", "Where's the nearest spaceport?", "Goodbye."]
var can_select = true

func _ready():
	dialogue_animation(opening)
	add_options(options)

func dialogue_animation(opening):
	can_select = false
	$PromptHolder/Prompt.text = ""
	for ch in opening:
		$PromptHolder/Prompt.text += ch
		if Input.is_action_pressed("ui_accept"):
			$PromptHolder/Prompt.text = opening
			break
		yield(get_tree().create_timer(.02), "timeout")
	can_select = true

func add_options(options):
	for option in options:
		$LineList.add_item(option)


func _on_LineList_item_activated(index):
	if can_select:
		match index:
			0: dialogue_animation("Hello to yourself.")
			1: dialogue_animation("Go forward and turn left when you see the Empath conductor to the right.")
			2: dialogue_animation("See you.")
