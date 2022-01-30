extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_P1_health_zero():
	$WinLabel.text = "PLAYER TWO WINS!"


func _on_P2_health_zero():
	$WinLabel.text = "PLAYER ONE WINS!"
