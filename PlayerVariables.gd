extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var curr_position = -1
var gen = ""
var collision_width = 0
var tutorial_score = 0
var clean_score = 0
var eat_score = 0
var living_score = 0
var score = 0
var mistakes = 0
var answered_questions = []
var showing_menu = false
export var curr_difficulty = 1
var training_mode = false
var tutorial_seen = false
var curr_module
var locked = false
var voice_over = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
