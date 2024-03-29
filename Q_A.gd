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
				"Lavamanos": "Cerrar bien la llave luego \n de lavarme las manos"
			},
			"Bathroom": {
				"Inodoro": "Bajar el agua para \n dejarlo limpio",
				"Ducha": "Llevar la toalla para \n secar mi cuerpo",
				"Lavamanos": "Cerrar bien la llave luego \n de lavarme las manos"
			},
			"Kitchen": {
				"Nevera": "Cerrar la puerta para \n mantener el frío adentro",
				"Comedor": "Sentarme derechito para comer mejor",
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
				"Comedor": '"Tengo hambre, quiero comer \n algo calentito"',
				"Nevera": '"Tengo sed, quiero tomar \n algo frío"'
			},
			"LivingRoom": {
				"Sofa": '"Estoy cansado, voy \n a recostarme"',
				"Libros": '"Quiero leer"',
				"Televisor": '"Quiero ver una película"'
			}
		}
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
