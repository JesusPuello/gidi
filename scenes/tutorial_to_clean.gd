extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextArea_area_entered(area):
	PlayerVariables.score = 0
	PlayerVariables.mistakes = 0
	PlayerVariables.answered_questions = []
	Hud.save_preferences()
	$CollisionShape2D.set_deferred("disabled", true)
	PlayerVariables.curr_module = "Bathroom"
	get_tree().change_scene("res://utils/change_scene_scene.tscn")
