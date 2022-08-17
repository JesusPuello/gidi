extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Highlighted.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Highlighted.visible = selected
	pass
