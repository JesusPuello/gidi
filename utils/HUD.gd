extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var curr_player_state
var showing_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.visible = false
	showing_menu = false

func set_menu_visibility():
	$Menu.visible = !$Menu.visible
	if showing_menu:
		PlayerVariables.locked = curr_player_state
		showing_menu = false
		save_preferences()
	else:
		curr_player_state = PlayerVariables.locked
		PlayerVariables.locked = true
		showing_menu = true
	PlayerVariables.showing_menu = showing_menu
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score/Label.text = str(PlayerVariables.score)
	$Mistakes/Label.text = str(PlayerVariables.mistakes)
		
func play_correct():
	$CorrectAnswer.play()
	
func play_mistake():
	$Mistake.play()
	
func play_new_zone():
	$NewZone.play()

func play_victory():
	$Victory.play()
	
func play_perfect():
	$Perfect.play()

func play_select():
	$Select.play()

func hide(full_hide = true):
	$Score.visible = false
	$Mistakes.visible = false
	if full_hide:
		$Settings.visible = false
	
func show():
	$Score.visible = true
	$Mistakes.visible = true
	$Settings.visible = true

func process_saved_bus_data(data):
	PlayerVariables.voice_over = data.get("voice_over", true)
	$Menu/VoiceToggle.pressed = PlayerVariables.voice_over
	data.erase("voice_over")
	for key in data:
		$Menu.get_node(key).set("value", data[key])
		
func save_preferences():
	print("Save preferences attempt...")
	var preferences = "/games/" + Information.game_slug + "/preferences"
	var full_url = Information.back_end_url + preferences
	var headers = ["Content-type: application/json"]
	var body = to_json({
		"preferences": {
			"tutorial_seen": PlayerVariables.tutorial_seen,
			"voice_over": PlayerVariables.voice_over,
			"curr_difficulty": PlayerVariables.curr_difficulty,
			"GeneralVolume": $Menu/GeneralVolume.value,
			"StepsVolume": $Menu/StepsVolume.value,
			"AlertsVolume": $Menu/AlertsVolume.value,
			"SelectVolume": $Menu/SelectVolume.value,
			"VoiceVolume": $Menu/VoiceVolume.value
		}
	})
	$HTTPRequest.request(full_url, headers, false, HTTPClient.METHOD_POST, body)

func _on_Settings_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_left_click"):
		set_menu_visibility()
		Input.action_release("mouse_left_click")
		
func _on_Quit_pressed():
	get_tree().quit()


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Save status: " + str(response_code))
