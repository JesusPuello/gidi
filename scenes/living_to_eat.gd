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


func _on_PreviousArea_area_entered(area):
	$CollisionShape2D.set_deferred("disabled", true)
	PlayerVariables.curr_position = screen_size.x - (20 + PlayerVariables.collision_width)
	get_tree().change_scene("res://scenes/eat_module.tscn")
