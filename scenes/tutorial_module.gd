extends Node2D

var initial_score = 0
var required_score = 1
var finished_tutorial = false
var curr_reading
var moved = false
var got_to_target = false
var pressed_space_bar = false
var question_answered = false
var read_score_and_mistakes = false
func _ready():
	Hud.hide(false)
	PlayerVariables.curr_module = "Tutorial"
	PlayerVariables.collision_width = PlayerVariables.collision_width * $Player.scale.x
	if PlayerVariables.curr_position >= 0:
		$Player.position.x = PlayerVariables.curr_position
	if PlayerVariables.gen == "":
		PlayerVariables.gen = $Player.gen
	$Player.gen = PlayerVariables.gen
	curr_reading = $Directionals
	$Directionals/Sprite.visible = false
	$PressSpaceBar/Sprite.visible = false
	read_text()

func read_text():
	curr_reading.visible = true
	for node in get_tree().get_nodes_in_group("texts"):
		if node != curr_reading:
			node.visible = false
	$AppearingText.triggerer = curr_reading.get_node("Label")
	$AppearingText.execute_time()
			
func check_move():
	if not moved and (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
		moved = true
		curr_reading = $GoToTarget
		read_text()
		
func check_got_to_target():
	if not got_to_target and $Tutorial/ParallaxBackground/ParallaxLayer/Lavamanos.showing_spacebar:
		got_to_target = true
		curr_reading = $PressSpaceBar
		read_text()
		
func check_sprites():
	if curr_reading == $Directionals and $AppearingText.write_finish:
		$Directionals/Sprite.visible = true
	if curr_reading == $PressSpaceBar and $AppearingText.write_finish:
		$PressSpaceBar/Sprite.visible = true

func check_pressed_spacebar():
	if curr_reading == $PressSpaceBar and Input.is_action_just_pressed("action"):
		pressed_space_bar = true
		curr_reading = $QuestionRead
		$AppearingText/ReadAll.wait_time = 5
		read_text()
		$Tutorial/ParallaxBackground/ParallaxLayer/QuestionBody.locked = true
		
func pass_question_text():
	if curr_reading == $QuestionRead and $AppearingText.read == true:
		$Tutorial/ParallaxBackground/ParallaxLayer/QuestionBody.locked = false
		curr_reading = $QuestionRead2
		read_text()
		
func question_answered():
	if curr_reading == $QuestionRead2 and Input.is_action_just_pressed("action"):
		question_answered = true
		Hud.show()
		curr_reading = $Score
		read_text()
		
func pass_score_to_mistakes():
	if curr_reading == $Score and $AppearingText.read:
		curr_reading = $Mistakes
		read_text()
		
func read_score_and_mistakes():
	if curr_reading == $Mistakes and $AppearingText.read:
		read_score_and_mistakes = true
		curr_reading = $FinishedTutorial
		read_text()
		
func check_finished_tutorial():
	finished_tutorial = moved and got_to_target and pressed_space_bar and question_answered and read_score_and_mistakes

func _process(delta):
	if not PlayerVariables.showing_menu:
		check_sprites()
		check_move()
		check_got_to_target()
		check_pressed_spacebar()
		pass_question_text()
		question_answered()
		pass_score_to_mistakes()
		read_score_and_mistakes()
		check_finished_tutorial()
		if initial_score != PlayerVariables.score:
			PlayerVariables.tutorial_score += 1
			initial_score = PlayerVariables.score
			Hud.play_correct()
		if finished_tutorial:
			PlayerVariables.tutorial_seen = finished_tutorial
		$HandBody.visible = finished_tutorial
		$NextArea/CollisionShape2D.disabled = not finished_tutorial
