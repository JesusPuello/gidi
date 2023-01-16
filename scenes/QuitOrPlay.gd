extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	if name == "Quit":
		get_tree().quit()
	else:
		PlayerVariables.curr_difficulty = 1
		get_tree().change_scene(Information.module_name_scene[PlayerVariables.curr_module])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
