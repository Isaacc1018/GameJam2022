extends KinematicBody2D

var gravity = 400
const moveSpeed = 175
var jumpStr = -250
var velocity = Vector2.ZERO
var P1_Health = 100
var P2_Health = 100
var health = 100
var direction = 1


func _ready():
	pass

func get_input():
	velocity.x = floor(velocity.x/2)
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
		scale.y = scale.y*-1
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
		kt.set_wait_time(1.5)
		kt.set_one_shot(true)
		self.add_child(kt)
		kt.start()
		yield(kt, "timeout")
		kt.queue_free()
		$AnimatedSprite.frame=0
		$KickHitBox/CollisionShape2D.disabled = true
			

func _physics_process(delta):
	$Label.text = String(health)
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed(name+ "_Jump"):
		if is_on_floor() || is_on_ceiling():
			velocity.y = jumpStr
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PunchHitBox_body_entered(body):
	body.health -= 5
	body.velocity.x += 500*direction


func _on_KickHitBox_body_entered(body):
	body.health -= 10
	body.velocity.x += 1850*direction
