extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var transform_rate = Vector2(0.9, 0.9)
var initial_scales = []
var selected
var screen_size
var curr_section = 1
var moving = false
var target_position
var speed
var house_initial_scale
var appear_speed
var choose_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Preferences retrieval attempt...")
	get_preferences()
	house_initial_scale = $House.scale
	$House.scale = Vector2(0,0)
	appear_speed = Vector2(house_initial_scale.x/50, house_initial_scale.y/50)
	screen_size = get_viewport_rect().size
	speed = screen_size.x/50
	for node in get_tree().get_nodes_in_group("main_2"):
		node.position.x += screen_size.x
	PlayerVariables.locked = true
	Hud.hide()
	initial_scales = [$Boy.scale, $Girl.scale]
	$Girl/Directionals.visible = false
	$Boy/Directionals.visible = false
	$Boy/AnimatedSprite.flip_h = true
	$AppearingText.triggerer = $Welcome/Label
	$AppearingText.execute_time()
	if PlayerVariables.voice_over:
		$Welcome_audio.play()

func section_2():
	if not choose_played:
		if PlayerVariables.voice_over:
			$Character_audio.play()
		choose_played = true
	if Input.is_action_just_pressed("move_right"):
		if !$Boy.is_selected:
			selected = $Boy
			$Boy.is_selected = true
			$Girl.is_selected = false
			$Boy.scale = $Boy.scale + transform_rate
			$Girl.scale = initial_scales[1]
	if Input.is_action_just_pressed("move_left"):
		if !$Girl.is_selected:
			selected = $Girl
			$Girl.is_selected = true
			$Boy.is_selected = false
			$Girl.scale = $Girl.scale + transform_rate
			$Boy.scale = initial_scales[0]
	if Input.is_action_just_pressed("action"):
		if selected:
			PlayerVariables.gen = selected.name
			Hud.show()
			Hud.play_select()
			PlayerVariables.locked = false
			if PlayerVariables.tutorial_seen:
				PlayerVariables.curr_module = "Bathroom"
				get_tree().change_scene("res://utils/change_scene_scene.tscn")
			else:
				get_tree().change_scene("res://scenes/tutorial_module.tscn")

func next_section():
	moving = true
	target_position = position.x - screen_size.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		if position.x > target_position:
			position.x -= speed
			$Polygon2D.position.x += speed
		else:
			moving = false
			curr_section += 1
	if curr_section == 1 and $AppearingText.write_finish and $House.scale < house_initial_scale:
		$House.scale += appear_speed
	if curr_section == 1 and $AppearingText.read and not moving:
		next_section()
	if curr_section == 2 and not moving:
		section_2()

func get_preferences():
	var preferences = "/games/" + Information.game_slug + "/preferences"
	var full_url = Information.back_end_url + preferences
	var headers = ["Content-type: application/json"]

	$HTTPRequest.request(full_url, headers, false, HTTPClient.METHOD_GET)
	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code >= 200 and response_code < 300:
		print("BODY")
		var byte_array_to_text = body.get_string_from_utf8()
		var json_result = JSON.parse(byte_array_to_text)
		if not json_result.error:
			var parsed_data = json_result.result
			var information = parsed_data.get("data", {}).get("preferences")
			print("Retreived information: " + str(information))
			PlayerVariables.tutorial_seen = information.get("tutorial_seen", false)
			PlayerVariables.curr_difficulty = information.get("curr_difficulty", 1)
			information.erase("tutorial_seen")
			information.erase("curr_difficulty")
			Hud.process_saved_bus_data(information)
	print("Preferences retrieval status: " + str(response_code))
