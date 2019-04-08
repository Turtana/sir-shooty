extends Control

export var opening = "Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not. It’s not a story the Jedi would tell you. It’s a Sith legend. Darth Plagueis was a Dark Lord of the Sith, so powerful and so wise he could use the Force to influence the midichlorians to create life… He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. The dark side of the Force is a pathway to many abilities some consider to be unnatural. He became so powerful… the only thing he was afraid of was losing his power, which eventually, of course, he did. Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself."

var ch_name = "Zirra"
var options = ["Hello fellow alien.", "Where's the nearest spaceport?", "Goodbye."]
var option_answers = ["Hello to yourself.", "Go forward and turn left when you see the Empath conductor on the right.", "See you."]
var can_select = true

func _ready():
	$Name.text = ch_name
	dialogue_animation(opening)
	add_options(options)
	$CharImage/AnimationPlayer.play("empath_float")

func dialogue_animation(opening):
	can_select = false
	$PromptHolder/Prompt.text = ""
	for ch in opening:
		$PromptHolder/Prompt.text += ch
		if Input.is_action_pressed("ui_cancel"):
			$PromptHolder/Prompt.text = opening
			break
		yield(get_tree().create_timer(0.02), "timeout")
	can_select = true

func add_options(options):
	for option in options:
		$LineList.add_item(option)


func _on_LineList_item_activated(index):
	if can_select:
		dialogue_animation(option_answers[index])
