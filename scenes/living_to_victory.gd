extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextArea_area_entered(area):
	$CollisionShape2D.set_deferred("disabled", true)
	PlayerVariables.curr_position = 20 + PlayerVariables.collision_width
	if PlayerVariables.training_mode:
		PlayerVariables.curr_module = "LivingRoom"
		get_tree().change_scene("res://utils/change_scene_scene.tscn")
	else:
		get_tree().change_scene("res://scenes/victory_screen.tscn")
