extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 75
export (int) var flag = 1
var acum = 0
export var move_x = false
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	acum += delta
	if acum>0.50:
		flag = flag * -1
		acum = 0
	if move_x:
		velocity.x = 1 * flag * speed
	else:
		velocity.y = 1 * flag * speed
	velocity = move_and_slide(velocity)
	pass
