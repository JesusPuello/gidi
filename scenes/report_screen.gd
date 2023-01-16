extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Report/Label.text = Q_stats.report()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("action"):
		PlayerVariables.mistakes = 0
		if PlayerVariables.finished_game:
			get_tree().change_scene("res://scenes/finish_screen.tscn")
		else:
			get_tree().change_scene("res://utils/change_scene_scene.tscn")
