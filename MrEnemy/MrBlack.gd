extends CharacterBody2D


@export var aniFrame = 0
@export var health = 60


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
signal struckByBullet()


func hitByBullet(Damage):
	$Audio/enemyHit.play()
	emit_signal("struckByBullet")
	health -= Damage
	if health <= 0:
		await get_tree().create_timer(.3).timeout
		queue_free()

func enemyFunction():
	pass

func _physics_process(delta):
	pass
	"""
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	"""

"""
func aniEnemy():
	var vx = velocity.x
	var vy = velocity.y
	
	if invert == 0:
		$Black.visible = true
		$White.visible = false
		eg = last
		if vx > aniCut and abs(vx) > abs(vy):
			$Black/BlAni.play("WalkR")
			#$Audio/stepSound.play()
			last = 0
		elif vx < -aniCut and abs(vx) > abs(vy):
			$Black/BlAni.play("WalkL")
			last = 1
		elif vy < -aniCut and abs(vy) > abs(vx):
			$Black/BlAni.play("WalkAway")
			last = 2
		elif vy > aniCut and abs(vy) > abs(vx):
			$Black/BlAni.play("WalkTo")
			last = 3
		
		elif vx > -aniCut and vx < aniCut and vy > -aniCut and vy < aniCut:
			if last == 0:
				$Black/BlAni.play("FRight")
			elif last == 1:
				$Black/BlAni.play("FLeft")
			elif last == 2:
				$Black/BlAni.play("FAway")
			elif last == 3:
				$Black/BlAni.play("FTo")
	else:
		eg = last
		$Black.visible = false
		$White.visible = true
		if vx > aniCut and abs(vx) > abs(vy):
			$White/WhAni.play("WalkR")
			last = 0
		elif vx < -aniCut and abs(vx) > abs(vy):
			$White/WhAni.play("WalkL")
			last = 1
		elif vy < -aniCut and abs(vy) > abs(vx):
			$White/WhAni.play("WalkAway")
			last = 2
		elif vy > aniCut and abs(vy) > abs(vx):
			$White/WhAni.play("WalkTo")
			last = 3
		
		elif vx > -aniCut and vx < aniCut and vy > -aniCut and vy < aniCut:
			if last == 0:
				$White/WhAni.play("FRight")
			elif last == 1:
				$White/WhAni.play("FLeft")
			elif last == 2:
				$White/WhAni.play("FAway")
			elif last == 3:
				$White/WhAni.play("FTo")
"""
