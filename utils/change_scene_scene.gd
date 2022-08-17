extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
var curr_section = 1
var locked_section_2 = true
var curr_option
var moving
var speed
var target_position
var showing_section_1_text = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Play/Highlight.visible = false
	curr_option = $Guide
	curr_option.get_node("Highlight").visible = true
	screen_size = get_viewport().size
	speed = screen_size.x/50
	target_position = position.x - screen_size.x
	Hud.hide()
	for node in get_tree().get_nodes_in_group("change_scene_2"):
		if "rect_position" in node:
			node.rect_position.x += screen_size.x
		else:
			node.position.x += screen_size.x
	$AppearingText/ReadAll.wait_time = 4
	$AppearingText.triggerer = $ChangeSceneText/Label
	$AppearingText.execute_time()
	
func check_section_2_read():
	if curr_section == 2 and $AppearingText.read:
		locked_section_2 = false
		
func show_text():
	$ChangeSceneText/Label.text = Information.change_scene_texts[str(PlayerVariables.curr_difficulty)]
	var final_text = $ChangeSceneText/Label.text
	final_text += Information.module_name_mapper[PlayerVariables.curr_module]
	$ChangeSceneText/Label.text = final_text
	$AppearingText.triggerer = $ChangeSceneText/Label
	$AppearingText/ReadAll.wait_time = 5
	$AppearingText.execute_time()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_section_2_read()
	if moving:
		if position.x > target_position:
			position.x -= speed
			$Polygon2D.position.x += speed
		else:
			moving = false
			curr_section += 1
	if not locked_section_2 and not moving:
		if Input.is_action_just_pressed("move_left") and $Guide/Highlight.visible == false:
			curr_option.get_node("Highlight").visible = false
			curr_option = $Guide
			curr_option.get_node("Highlight").visible = true
		if Input.is_action_just_pressed("move_right") and $Play/Highlight.visible == false:
			curr_option.get_node("Highlight").visible = false
			curr_option = $Play
			curr_option.get_node("Highlight").visible = true
		if Input.is_action_just_pressed("action"):
			curr_option.start()
			locked_section_2 = true
			get_tree().change_scene(Information.module_name_scene[PlayerVariables.curr_module])
			
	if not moving and curr_section == 1 and not showing_section_1_text:
		showing_section_1_text = true
		show_text()
	if not moving and curr_section == 1 and $AppearingText.read:
		$AppearingText.read = false
		$AppearingText.triggerer = $MainText1/Label
		$AppearingText/ReadAll.wait_time = 0.25
		moving = true
		$AppearingText.execute_time()
	
