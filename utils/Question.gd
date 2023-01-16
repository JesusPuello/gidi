extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var opt_number
export var expected_answer = ""
var triggerer
var target_position
var screen_size
var initial_position
var move_out = false
var locked = false
var read = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	target_position = $".".position.y
	initial_position = $".".position.y - screen_size.y
	position.y = initial_position
	opt_number = 2
	$Option1.selected = false
	$Option2.selected = true
	$Option3.selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not PlayerVariables.showing_menu:
		if move_out:
			if $".".position.y > initial_position:
				$".".position.y -= 20
			else:
				PlayerVariables.locked = false
				visible = false
				move_out = false
				opt_number = 2
				$Option1.selected = false
				$Option2.selected = true
				$Option3.selected = false
		if visible and not move_out:
			$Objeto.texture = load("res://backgrounds/images/elements/" + str(triggerer.name) + ".PNG")
			if $".".position.y < target_position:
				$".".position.y += 20
			else:
				if not locked:
					if not read and PlayerVariables.voice_over:
						$".".get_node("level_" + str(PlayerVariables.curr_difficulty)).play()
						read = true
					if Input.is_action_just_pressed("move_right"):
						if opt_number != 3:
							get_node("Option" + str(opt_number)).selected = false
							get_node("Option" + str(opt_number)).get_node("AudioPlayer").stop()
							opt_number += 1
							get_node("Option" + str(opt_number)).selected = true
							if PlayerVariables.voice_over:
								get_node("Option" + str(opt_number)).get_node("AudioPlayer").play()
					if Input.is_action_just_pressed("move_left"):
						if opt_number != 1:
							get_node("Option" + str(opt_number)).selected = false
							get_node("Option" + str(opt_number)).get_node("AudioPlayer").stop()
							opt_number -= 1
							get_node("Option" + str(opt_number)).selected = true
							if PlayerVariables.voice_over: 
								get_node("Option" + str(opt_number)).get_node("AudioPlayer").play()
					if Input.is_action_just_pressed("action"):
						Hud.play_select()
						if get_node("Option" + str(opt_number)).get_node("Label").text == expected_answer:
							PlayerVariables.score += 1
							triggerer.answered = true
							triggerer.get_node("Sprite").visible = false
							triggerer.get_node("CollisionShape2D").disabled = true
							PlayerVariables.answered_questions.append(triggerer.name)
						else:
							Q_stats.objects[triggerer.name] += 1
							PlayerVariables.mistakes += 1
							Hud.play_mistake()
						Input.action_release("action")
						move_out = true
						read = false
