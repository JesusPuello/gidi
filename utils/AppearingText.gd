extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var triggerer
var display = ""
var current_char = 0
var message = ""
var write_finish = false
var read = false
var writing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func execute_time():
	$ReadAll.stop()
	read = false
	write_finish = false
	message = triggerer.text
	triggerer.text = ""
	current_char = 0
	display = ""
	$NextChar.start()


func _on_NextChar_timeout():
	if current_char < len(message):
		writing = true
		var next_char = message[current_char]
		display += next_char
		triggerer.text = display
		current_char += 1
	else:
		writing = false
		write_finish = true
		$NextChar.stop()
		$ReadAll.start()


func _on_ReadAll_timeout():
	read = true
