extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var locked_section = false
var curr_option
# Called when the node enters the scene tree for the first time.
func _ready():
	$Quit/Highlight.visible = false
	curr_option = $Play
	curr_option.get_node("Highlight").visible = true
	Hud.hide()
	$AppearingText/ReadAll.wait_time = 4
	$AppearingText.triggerer = $MainText1/Label
	$AppearingText.execute_time()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not locked_section:
		if Input.is_action_just_pressed("move_left") and $Play/Highlight.visible == false:
			curr_option.get_node("Highlight").visible = false
			curr_option = $Play
			curr_option.get_node("Highlight").visible = true
			if PlayerVariables.voice_over:
				$ReplayAudio.play()
		if Input.is_action_just_pressed("move_right") and $Quit/Highlight.visible == false:
			curr_option.get_node("Highlight").visible = false
			curr_option = $Quit
			curr_option.get_node("Highlight").visible = true
			if PlayerVariables.voice_over:
				$QuitAudio.play()
		if Input.is_action_just_pressed("action"):
			curr_option.start()
			
	
