extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var victory_message_read = false
var victory_sound
func save_score():
	print("Score save attempt...")
	var score_route = "/games/" + Information.game_slug + "/scores"
	var full_url = Information.back_end_url + score_route
	var headers = ["Content-type: application/json"]
	var total = float(PlayerVariables.score + PlayerVariables.mistakes)
	var score_percent = float(PlayerVariables.score) / total
	var final_score = int(round(score_percent*100.0))
	var body = to_json({
		"score": final_score,
		"difficulty": PlayerVariables.curr_difficulty
	})
	$HTTPRequest.request(full_url, headers, false, HTTPClient.METHOD_POST, body)

func get_mistakes_victory_message():
	if PlayerVariables.mistakes < 2:
		return "¡¡Subes al siguiente nivel!!" if PlayerVariables.curr_difficulty != 3 else "¡¡Excelente, completaste \n todos los niveles!!"
	elif PlayerVariables.mistakes < 4:
		return "¡Ya casi subes \n al siguiente nivel!"
	elif PlayerVariables.mistakes < 6:
		return "Puedes hacerlo aún mejor"
	else:
		return "Sigue así, \n el objetivo es aprender"

func get_mistakes_victory_sound():
	var message
	if PlayerVariables.mistakes < 2:
		message = "siguiente_nivel" if PlayerVariables.curr_difficulty != 3 else "todos_niveles"
	elif PlayerVariables.mistakes < 4:
		message = "casi_subes"
	elif PlayerVariables.mistakes < 6:
		message = "aun_mejor"
	else:
		message = "objetivo_aprender"
	var audio_file = "res://sound_effects/victory_messages/{message}.mp3".format({ 
		"message": message
		})
	if File.new().file_exists(audio_file):
		var sfx = load(audio_file)
		sfx.set_loop(false)
		return sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	Hud.hide()
	Hud.play_victory() if PlayerVariables.mistakes >= 2 else Hud.play_perfect()
	save_score()
	PlayerVariables.score = 0
	PlayerVariables.answered_questions = []
	PlayerVariables.curr_module = "Bathroom"
	PlayerVariables.eat_score = 0
	PlayerVariables.living_score = 0
	PlayerVariables.clean_score = 0
	Hud.save_preferences()
	$VictoryText/Label.text = get_mistakes_victory_message()
	$AppearingText.triggerer = $VictoryText/Label
	$AppearingText.execute_time()
	victory_sound = get_mistakes_victory_sound()
	if PlayerVariables.curr_difficulty != 3:
		PlayerVariables.curr_difficulty += 1 if PlayerVariables.mistakes < 2 else 0
	else:
		PlayerVariables.finished_game = true if PlayerVariables.mistakes < 2 else  false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not victory_message_read and not Hud.victory_playing():
		victory_message_read = true
		$AudioPlayer.stream = victory_sound
		if PlayerVariables.voice_over:
			$AudioPlayer.play()
	if $AppearingText.read:
		get_tree().change_scene("res://scenes/report_screen.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Save status: " + str(response_code))
