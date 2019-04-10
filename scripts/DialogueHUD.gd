extends Control

export var opening = "Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not. It’s not a story the Jedi would tell you. It’s a Sith legend. Darth Plagueis was a Dark Lord of the Sith, so powerful and so wise he could use the Force to influence the midichlorians to create life… He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. The dark side of the Force is a pathway to many abilities some consider to be unnatural. He became so powerful… the only thing he was afraid of was losing his power, which eventually, of course, he did. Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself."
export var ch_name = "Zirra"
export var options = ["Hello fellow alien.", "Where's the nearest spaceport?", "Goodbye."]
export var option_answers = ["Hello to yourself.", "Go forward and turn left when you see the Empath conductor on the right.", "See you."]
# options and option_answers NEED to be in the same order. Option MUST have the same index number as its answer!

var can_select = true

func _ready():
	$Name.text = ch_name
	dialogue_animation(opening)
	add_options(options)
	$CharImage/AnimationPlayer.play("empath_float")

func dialogue_animation(line):
	can_select = false
	$PromptHolder/Prompt.text = ""
	for ch in line:
		$PromptHolder/Prompt.text += ch
		if Input.is_action_pressed("ui_cancel"):
			$PromptHolder/Prompt.text = line
			break
		yield(get_tree().create_timer(0.02), "timeout")
	can_select = true

func add_options(options):
	var ctr = 0
	for option in options:
		$LineList.add_item(option)
		$LineList.set_item_tooltip_enabled(ctr, false)
		ctr += 1

func _on_LineList_item_activated(index):
	if can_select:
		dialogue_animation(option_answers[index])
#		Get the index of an option and find its counterpart from the answers.
