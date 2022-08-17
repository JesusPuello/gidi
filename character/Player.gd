extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var locked = false
var is_selected = false
export(String, "Girl", "Boy") var gen
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.animation = "Idle" + gen
	PlayerVariables.collision_width = $CollisionShape2D.shape.radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	locked = PlayerVariables.locked
	if not locked:
		var velocity = Vector2.ZERO # The player's movement vector.
		var show_directionals = true
		for node in get_tree().get_nodes_in_group("events"):
			if node.showing_spacebar:
				show_directionals = false
				break
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite.play()
		else:
			$AnimatedSprite.stop()
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		
		if velocity.x != 0:
			if !$Steps.is_playing():
				$Steps.play()
			$AnimatedSprite.animation = "Walk" + gen
			$Directionals.visible = false
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
		else:
			$Steps.stop()
			$Directionals.visible = show_directionals
			$AnimatedSprite.animation = "Idle" + gen
	else:
		$AnimatedSprite.animation = "Idle" + gen
