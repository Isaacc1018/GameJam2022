extends KinematicBody2D

var gravity = 200
const moveSpeed = 250
var jumpStr = -250
var velocity = Vector2.ZERO


func _ready():
	pass

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("Right"):
		velocity.x += moveSpeed
	if Input.is_action_pressed("Left"):
		velocity.x -= moveSpeed
	if Input.is_action_just_pressed("Flip"):
		gravity = gravity * -1
		jumpStr = jumpStr * -1
		position.y=position.y*-1
		$PlaceHolderSprite.scale.y = $PlaceHolderSprite.scale.y*-1

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor() || is_on_ceiling():
			velocity.y = jumpStr
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
