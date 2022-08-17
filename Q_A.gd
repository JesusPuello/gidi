extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var questions
var answers
var required_score
# Called when the node enters the scene tree for the first time.
func _ready():
	questions = {
		"1": "¿Cuál es mi nombre?",
		"2": "Cuando me usas, ¿qué no debes olvidar?",
		"3": "¿Qué dices cuando me necesitas?"
	}
	required_score = {
		"1": {
			"Bathroom": 4,
			"Kitchen": 3,
			"LivingRoom": 3,
			"Total": 10
		},
		"2": {
			"Bathroom": 3,
			"Kitchen": 3,
			"LivingRoom": 2,
			"Total": 8
		},
		"3": {
			"Bathroom": 3,
			"Kitchen": 2,
			"LivingRoom": 3,
			"Total": 8
		}
	}
	answers = {
		"1": {
			"Tutorial": {
				"Lavamanos": "Lavamanos"
			},
			"Bathroom": {
				"Inodoro": "Inodoro",
				"Ducha": "Ducha",
				"Lavamanos": "Lavamanos",
				"Tina": "Tina"
			},
			"Kitchen": {
				"Nevera": "Nevera",
				"Estufa": "Estufa",
				"Comedor": "Comedor"
			},
			"LivingRoom": {
				"Sofa": "Sofá",
				"Libros": "Libros",
				"Televisor": "Televisor"
			}
		},
		"2": {
			"Tutorial": {
				"Lavamanos": "Secarme las manos y cerrar la llave"
			},
			"Bathroom": {
				"Inodoro": "Lavarme las manos",
				"Ducha": "Llevar la toalla",
				"Lavamanos": "Secarme las manos y cerrar la llave"
			},
			"Kitchen": {
				"Nevera": "Cerrar la puerta",
				"Comedor": "Sentarme bien",
				"Estufa": "Si estoy cerca, evito tocar"
			},
			"LivingRoom": {
				"Televisor": "Apagarlo cuando no se está usando",
				"Libros": "Cuando leo, aprendo"
			}
		},
		"3": {
			"Tutorial": {
				"Lavamanos": '"Quiero lavarme las manos"',
			},
			"Bathroom": {
				"Inodoro": '"Necesito ir al baño"',
				"Lavamanos": '"Quiero lavarme las manos"',
				"Ducha": '"Me voy a bañar"'
			},
			"Kitchen": {
				"Comedor": '"Tengo hambre"',
				"Nevera": '"Tengo sed"'
			},
			"LivingRoom": {
				"Sofa": '"Estoy cansado"',
				"Libros": '"Quiero leer"',
				"Televisor": '"Quiero ver una película"'
			}
		}
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
