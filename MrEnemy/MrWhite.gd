extends CharacterBody2D
#WALTUH
class_name Enemy

@export var aniFrame = 0
@export var health = 60

@onready var egMarker = $egR
@onready var brain = $Brain

signal struckByBullet()
signal bulletFired(bullet)
signal enemyDied()

func _ready():
	brain.starter(self)




func hitByBullet(Damage):
	
	$Audio/enemyHit.play()
	emit_signal("struckByBullet")
	health -= Damage
	if health <= 0:
		emit_signal("enemyDied")
		await get_tree().create_timer(.3).timeout
		queue_free()

func enemyFunction():
	pass

var madeContact = false
var last = 0

func _physics_process(delta):
	if madeContact:
		brain.getEG(last)
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
var rng2 = RandomNumberGenerator.new()
var speedMult = rng2.randi_range(3, 7)

func _on_brain_fire_bullet(bullet):
	emit_signal("bulletFired", bullet)


func _on_brain_get_info():
	$Brain.receiveInfo($egR, $egL, $egA, $egT)


func aniEnemy():
	var invert = 1
	var vx = velocity.x
	var vy = velocity.y
	var aniCut = 7
	#eg = last
	#$Black.visible = false
	#$White.visible = true
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

var direction = Vector2.ZERO
#velocity = Vector2.ZERO
var acceleration = 0.15
var speed = 80
var friction = 0.1



func _on_brain_move_to_player(vecToPlayer, velocitee, Speed, Acceleration, Friction):
	madeContact = true
	direction = vecToPlayer
	velocity = velocitee
	speed = Speed * speedMult
	acceleration = Acceleration
	friction = Friction
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	aniEnemy()
	move_and_slide()

var particleTime = .2

func _on_brain_psst_a():
	$egA/psst.emitting = true
	await get_tree().create_timer(particleTime).timeout
	$egA/psst.emitting = false

func _on_brain_psst_l():
	$egL/psst.emitting = true
	await get_tree().create_timer(particleTime).timeout
	$egL/psst.emitting = false


func _on_brain_psst_r():
	$egR/psst.emitting = true
	await get_tree().create_timer(particleTime).timeout
	$egR/psst.emitting = false


func _on_brain_psst_t():
	$egT/psst.emitting = true
	await get_tree().create_timer(particleTime).timeout
	$egT/psst.emitting = false


func _on_brain_state_changed(state):
	brain.SBB()
