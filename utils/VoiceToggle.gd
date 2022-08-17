extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed = PlayerVariables.voice_over


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VoiceToggle_toggled(button_pressed):
	PlayerVariables.voice_over = button_pressed
