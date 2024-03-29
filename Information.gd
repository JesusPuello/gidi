extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var answers
var change_scene_texts
var module_name_mapper
var module_name_scene
var game_slug = "Gidi-game"
var back_end_url = "http://localhost:3030/api"
# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene_texts = {
		"1": "Ahora, aprenderemos los nombres de \n los objetos que puedes encontrar \n en ",
		"2": "Ahora, aprenderemos qué debemos \n recordar de los objetos en ",
		"3": "Ahora, aprenderemos qué decir \n cuando necesitamos un objeto \n en "
	}
	module_name_mapper = {
		"Bathroom": "el baño",
		"Kitchen": "la cocina",
		"LivingRoom": "la sala"
	}
	module_name_scene = {
		"Bathroom": "res://scenes/clean_module.tscn",
		"Kitchen": "res://scenes/eat_module.tscn",
		"LivingRoom": "res://scenes/living_module.tscn"
	}
	answers = {
		"1": {
			"Bathroom": {
				"Inodoro": "Soy el inodoro, bajito y elegante",
				"Ducha": "Me llamo ducha y me encanta dejarte limpio",
				"Lavamanos": "Mi nombre es lavamanos, tú sabes, lava-manos",
				"Tina": "Yo soy la tina, siempre acostada en una esquina"
			},
			"Kitchen": {
				"Nevera": "Yo soy la nevera, la más alta de mis amigos",
				"Estufa": "Mi nombre es estufa, la reina de la cocina",
				"Comedor": "Me llamo comedor, pero nunca soy quien come"
			},
			"LivingRoom": {
				"Sofa": "Si escuchas 'Sofá', ese soy yo",
				"Libros": "Somos los libros: tenemos letritas y dibujitos",
				"Televisor": "En la sala soy el jefe, soy el televisor"
			}
		},
		"2": {
			"Bathroom": {
				"Inodoro": "Recuerda bajar el agua \n para dejarme limpio",
				"Ducha": "Si no traes tu toalla, no podrás secarte el cuerpo",
				"Lavamanos": "Siempre cierra bien la llave luego \n de lavarte las manos, así cuidas el agua"
			},
			"Kitchen": {
				"Nevera": "Si no me necesitas, cierra la puerta \n para mantener el frío, por favor",
				"Comedor": "Me encanta el orden, \n recuerda sentarte derechito",
				"Estufa": "Suelo estar muy caliente, \n evita tocarme si te acercas"
			},
			"LivingRoom": {
				"Televisor": "Apágame cuando no me uses, \n te lo dice el jefe",
				"Libros": "Cuando nos lees, aprendes. \n ¡Hazlo más seguido!"
			}
		},
		"3": {
			"Bathroom": {
				"Inodoro": 'Si quieres usarme di: "Necesito ir al baño"',
				"Lavamanos": 'Me encanta escuchar: "Quiero lavarme las manos"',
				"Ducha": '"Me voy a bañar", \n palabras mágicas para usarme'
			},
			"Kitchen": {
				"Comedor": 'Cuando me necesites di: "Tengo hambre, \n quiero comer algo calentito"',
				"Nevera": '"Tengo sed", dices tú; algo frío te doy yo'
			},
			"LivingRoom": {
				"Sofa": 'Si dices: "Estoy cansado", siempre te dejaré \n recostarte en mí',
				"Libros": 'Qué bonito se escucha: \n "Quiero leer"',
				"Televisor": '¿Dijiste: "Quiero ver una película"? \n ¿Cuál quieres?'
			}
		}
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
