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
	$CollisionShape2D.set_deferred("disabled", true)
	PlayerVariables.curr_position = 20 + PlayerVariables.collision_width
	PlayerVariables.curr_module = "Bathroom" if PlayerVariables.training_mode else "Kitchen"
	get_tree().change_scene("res://utils/change_scene_scene.tscn")
