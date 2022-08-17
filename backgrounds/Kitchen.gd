extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var screen_size
var all_answered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$ParallaxBackground/ParallaxLayer/QuestionBody.visible = false
	$ParallaxBackground/ParallaxLayer/InformationBody.visible = false
	$ParallaxBackground/ParallaxLayer.position.x = screen_size.x/2
	$ParallaxBackground/ParallaxLayer.position.y = screen_size.y/2
	for name in PlayerVariables.answered_questions:
		if $ParallaxBackground/ParallaxLayer.has_node(name):
			var node = $ParallaxBackground/ParallaxLayer.get_node(name)
			node.get_node("CollisionShape2D").disabled = true
			node.get_node("Sprite").visible = false
	for node in get_tree().get_nodes_in_group("events"):
		if not node.name in Q_A.answers[str(PlayerVariables.curr_difficulty)]["Kitchen"]:
			node.get_node("CollisionShape2D").disabled = true
			node.get_node("Sprite").visible = false
			node.answered = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var all_true = true
	for node in get_tree().get_nodes_in_group("events"):
		all_true = all_true and node.answered
	all_answered = all_true
