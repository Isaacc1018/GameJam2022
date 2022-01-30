extends KinematicBody2D


var gravity = 475
const moveSpeed = 175
var jumpStr = -275
var velocity = Vector2.ZERO
var health = 100
var direction = 1
var stunTimer = Timer.new()

signal health_zero


func _ready():
	stunTimer.set_one_shot(true)
	stunTimer.set_wait_time(0.2)
	if name == "P2":
		gravity = gravity * -1
		jumpStr = jumpStr * -1
		$AnimatedSprite.scale.y = -1
		$BodyHitBox.scale.y = -1
	pass

func get_input():
	velocity.x = floor(velocity.x/2)
	if !stunTimer.is_stopped():
		print("stunned")
		return
	if Input.is_action_pressed(name+ "_Right"):
		velocity.x += moveSpeed
		$AnimatedSprite.scale.x = 1
		$PunchHitBox.scale.x = 1
		$KickHitBox.scale.x = 1
		direction = 1
	if Input.is_action_pressed(name+ "_Left"):
		velocity.x -= moveSpeed
		$AnimatedSprite.scale.x = -1
		$PunchHitBox.scale.x = -1
		$KickHitBox.scale.x =-1
		direction = -1
	if Input.is_action_just_pressed(name+ "_Flip"):
		gravity = gravity * -1
		jumpStr = jumpStr * -1
		position.y=position.y*-1
		$AnimatedSprite.scale.y = $AnimatedSprite.scale.y*-1
		$BodyHitBox.scale.y = $AnimatedSprite.scale.y
	if Input.is_action_just_pressed(name+ "_Punch"):
		$AnimatedSprite.frame=1
		$PunchHitBox/CollisionShape2D.disabled = false
		var t = Timer.new()
		t.set_wait_time(0.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		$AnimatedSprite.frame=0
		$PunchHitBox/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed(name+ "_Kick"):
		$AnimatedSprite.frame=3
		var pkt = Timer.new()
		pkt.set_wait_time(.35)
		pkt.set_one_shot(true)
		self.add_child(pkt)
		pkt.start()
		yield(pkt, "timeout")
		pkt.queue_free()
		$AnimatedSprite.frame=2
		$KickHitBox/CollisionShape2D.disabled = false
		var kt = Timer.new()
		kt.set_wait_time(.75)
		kt.set_one_shot(true)
		self.add_child(kt)
		kt.start()
		yield(kt, "timeout")
		kt.queue_free()
		$AnimatedSprite.frame=0
		$KickHitBox/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed(name+ "_Jump"):
		if is_on_floor() || is_on_ceiling():
			velocity.y = jumpStr

func _physics_process(delta):
	$Label.text = String(health)
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	if health <= 0:
		emit_signal("health_zero")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PunchHitBox_body_entered(body):
	if body.get_class() == "KinematicBody2D" and health > 0:
			body.health = clamp(body.health - 5, 0 , 100)
			body.velocity.x += 900*direction	


func _on_KickHitBox_body_entered(body):
	if body.get_class() == "KinematicBody2D" and health > 0:
			body.health = clamp(body.health - 10, 0 , 100)
			body.velocity.x += 2850*direction
