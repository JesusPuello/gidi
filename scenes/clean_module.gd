extends Node2D

var initial_score = 0
var required_score
func _ready():
	PlayerVariables.curr_module = "Bathroom"
	initial_score = PlayerVariables.score
	PlayerVariables.collision_width = PlayerVariables.collision_width * $Player.scale.x
	if PlayerVariables.curr_position >= 0:
		$Player.position.x = PlayerVariables.curr_position
	if PlayerVariables.gen == "":
		PlayerVariables.gen = $Player.gen
	$Player.gen = PlayerVariables.gen
	required_score = Q_A.required_score[str(PlayerVariables.curr_difficulty)]["Bathroom"]
	Hud.hide(false) if PlayerVariables.training_mode else Hud.show()

func _process(delta):
	if initial_score != PlayerVariables.score:
		PlayerVariables.clean_score += 1
		initial_score = PlayerVariables.score
		if PlayerVariables.clean_score == required_score:
			Hud.play_new_zone()
		else:
			Hud.play_correct()
	if !PlayerVariables.training_mode:
		$HandBody.visible = PlayerVariables.clean_score == required_score
		$NextArea/CollisionShape2D.disabled = PlayerVariables.clean_score < required_score
	else:
		$HandBody.visible = $Background.all_answered
		$NextArea/CollisionShape2D.disabled = not $Background.all_answered

