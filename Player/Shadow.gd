extends AnimatedSprite

var player = null
var binded= false


func _ready():
	pass



func _physics_process(_delta):
	if player != null:
		scale.y =    player.scale.y * -1
		position.x = player.position.x
		position.y = player.position.y * -1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if binded == false || body == KinematicBody2D:
		player = body
		binded = true
