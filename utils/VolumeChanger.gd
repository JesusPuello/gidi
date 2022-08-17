extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _bus


func _ready():
	var bus_selector = {
		"GeneralVolume": AudioServer.get_bus_index("Master"),
		"StepsVolume": AudioServer.get_bus_index("Steps"),
		"AlertsVolume": AudioServer.get_bus_index("Alerts"),
		"SelectVolume": AudioServer.get_bus_index("Select"),
		"VoiceVolume": AudioServer.get_bus_index("Voice")
	}
	_bus = bus_selector.get(name)
	value = db2linear(AudioServer.get_bus_volume_db(_bus))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_mouse_exited():
	release_focus()

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value)*2)
