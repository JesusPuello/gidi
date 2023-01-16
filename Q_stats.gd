extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var objects = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	Hud.hide()
	objects = {
		"Inodoro": 0,
		"Tina": 0,
		"Lavamanos": 0,
		"Ducha": 0,
		"Estufa": 0,
		"Nevera": 0,
		"Comedor": 0,
		"Sofa": 0,
		"Libros": 0,
		"Televisor": 0
	}

func report():
	var format_string = """
	 Baño                          Cocina                           Sala          
Inodoro: {Inodoro}                 Estufa: {Estufa}                       Sofá: {Sofa}        
Tina: {Tina}                    Nevera: {Nevera}                  Libros: {Libros}   
Ducha: {Ducha}               Comedor: {Comedor}           Televisor: {Televisor}
Lavamanos: {Lavamanos}                                                                                     
"""
	return format_string.format(objects)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
