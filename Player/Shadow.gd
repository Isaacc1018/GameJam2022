extends AnimatedSprite

var player = null
var binded= false


func _ready():
	pass



func _physics_process(_elta):
	if Input.is_action_just_pressed("Flip"):
		scale.y = scale.y * -1
	if player != null:
		position.x = player.position.x
		position.y = player.position.y * -1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if binded == false || body == KinematicBody2D:
		player = body
		binded = true
