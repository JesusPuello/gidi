extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var expected_answer = ""
var triggerer
var target_position
var screen_size
var initial_position
var move_out = false
var time_running = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	target_position = $".".position.y
	initial_position = $".".position.y - screen_size.y
	position.y = initial_position


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
		if visible and not move_out:
			$Objeto.texture = load("res://backgrounds/images/elements/" + str(triggerer.name) + ".PNG")
			if $".".position.y < target_position:
				$".".position.y += 20
			else:
				if not time_running:
					$WaitInput.start()
					time_running = true
				if $WaitInput.time_left == 0:
					triggerer.answered = true
					triggerer.get_node("Sprite").visible = false
					triggerer.get_node("CollisionShape2D").disabled = true
					move_out = true
					time_running = false
				if Input.is_action_just_pressed("action"):
					$WaitInput.stop()
					triggerer.answered = true
					triggerer.get_node("Sprite").visible = false
					triggerer.get_node("CollisionShape2D").disabled = true
					move_out = true
					time_running = false
