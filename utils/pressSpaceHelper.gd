extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showing_spacebar = false
var answered = false
var locked = false
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Toggle_area_entered(area):
	showing_spacebar = true
	$Sprite.visible = true


func _on_Toggle_area_exited(area):
	showing_spacebar = false
	$Sprite.visible = false
	
func load_guide():
	get_parent().get_node("InformationBody").get_node("TextBody").get_node("Label").text = Information.answers[str(PlayerVariables.curr_difficulty)][PlayerVariables.curr_module][name]
	get_parent().get_node("InformationBody").get_node("TextBody").get_node("AudioPlayer").stream = get_option_audio("Guide" + name)
	Input.action_release("action")
	get_parent().get_node("InformationBody").visible = true
	get_parent().get_node("InformationBody").triggerer = self
	PlayerVariables.locked = true
	
func get_option_audio(object_name):
	var audio_file = "res://sound_effects/nivel_{difficulty}/{object}.mp3".format({ 
		"difficulty" : PlayerVariables.curr_difficulty,
		"object": object_name
		})
	if File.new().file_exists(audio_file):
		var sfx = load(audio_file)
		sfx.set_loop(false)
		return sfx
		

func load_question():
	rng.randomize()
	get_parent().get_node("QuestionBody").get_node("Question").get_node("Label").text = Q_A.questions[str(PlayerVariables.curr_difficulty)]
	var answer_option = rng.randi_range(1,3)
	var answer = Q_A.answers[str(PlayerVariables.curr_difficulty)][PlayerVariables.curr_module][name]
	var other_options = []
	var other_options_keys = []
	for module in ["Bathroom", "Kitchen", "LivingRoom"]:
		other_options.append_array(Q_A.answers[str(PlayerVariables.curr_difficulty)][module].values())
		other_options_keys.append_array(Q_A.answers[str(PlayerVariables.curr_difficulty)][module].keys())
	other_options.erase(answer)
	other_options_keys.erase(name)
	for option in [1,2,3]:
		if option == answer_option:
			get_parent().get_node("QuestionBody").get_node("Option" + str(option)).get_node("Label").text = answer
			get_parent().get_node("QuestionBody").get_node("Option" + str(option)).get_node("AudioPlayer").stream = get_option_audio(name)
		else: 
			var random_option = rng.randi_range(0, len(other_options)-1)
			get_parent().get_node("QuestionBody").get_node("Option" + str(option)).get_node("Label").text = other_options[random_option]
			get_parent().get_node("QuestionBody").get_node("Option" + str(option)).get_node("AudioPlayer").stream = get_option_audio(other_options_keys[random_option]) 
			other_options.remove(random_option)
			other_options_keys.remove(random_option)
	Input.action_release("action")
	get_parent().get_node("QuestionBody").visible = true
	get_parent().get_node("QuestionBody").triggerer = self
	get_parent().get_node("QuestionBody").expected_answer = answer
	PlayerVariables.locked = true
	
func _process(delta):
	locked = PlayerVariables.locked
	if showing_spacebar and Input.is_action_just_pressed("action") and not answered and not locked and not PlayerVariables.showing_menu:
		Hud.play_select()
		if !PlayerVariables.training_mode:
			load_question()
		else:
			load_guide()

