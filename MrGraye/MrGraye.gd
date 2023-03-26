extends CharacterBody2D

@export var friction = 0.15
@export var acceleration = 0.1
@export var speed = 200
@export var bullet: PackedScene
@export var shSo: Node

@onready var egMarker = $Cam/egR#.position
#var bulletFile = preload("res://Assets/Objects/bullet.tscn")
#var bullet_instance: bullet = bullet.instance()
signal inverted(invT_s, invert)
signal bulletFired(bullet)
signal shotTimer(STS, magAmt)
signal reloading(reloadTime, magSize)
signal emptyChamber()
signal struckByBullet()

var aniCut = 10
# 0 = black   1 = white
var invert = 0

var invT = true
var invT_s = 3
var last = 0

var shellPlay = 0
var canShoot = true
var STS = float(0.4)
var bullet_direction = Vector2.ZERO
#	--Away/Up = 0    Right = 90   Left = -90   Down/To = 180
var bullet_angle = 0

var canClick = true
var isReloading = false
var needReload = false
var canReload = true
var magSize = 11
var magAmt = magSize
var reloadTime = 2.4

var step = true
var stepSec = .30

#gunpoint Marker2D:: Right=0  Left=1  Away/Up=2  To/Down=3
var eg = last

var rng = RandomNumberGenerator.new()

var particleTime = 0.2

func playerFunction():
	pass

func hitByBullet():
	emit_signal("struckByBullet")

func slow():
	speed = 100
func regSpeed():
	speed = 200
func fast():
	speed = 300


#get gun direction
func get_eg():
	if eg == 0:
		egMarker = $egR
		bullet_angle = 90
		
		$egR/psst.emitting = true
		await get_tree().create_timer(particleTime).timeout
		$egR/psst.emitting = false
	elif eg == 1:
		egMarker = $egL
		bullet_angle = -90
		$egL/psst.emitting = true
		await get_tree().create_timer(particleTime).timeout
		$egL/psst.emitting = false
	elif eg == 2:
		egMarker = $egA
		bullet_angle = 0
		$egA/psst.emitting = true
		await get_tree().create_timer(particleTime).timeout
		$egA/psst.emitting = false
	elif eg == 3:
		egMarker = $egT
		bullet_angle = 180
		$egT/psst.emitting = true
		await get_tree().create_timer(particleTime).timeout
		$egT/psst.emitting = false
	#print(eg)
	#print(egMarker.global_position)


#get bullet direction
func get_bullet_direction():
	if eg == 0:
		bullet_direction.x = 1
		bullet_direction.y = 0
	elif eg == 1:
		bullet_direction.x = -1
		bullet_direction.y = 0
	elif eg == 2:
		bullet_direction.x =0
		bullet_direction.y = -1
	elif eg == 3:
		bullet_direction.x = 0
		bullet_direction.y = 1


func shellHitGround():
	shellPlay = rng.randi_range(0,5)
	if shellPlay == 0:
		$Audio/shellSound.play()
	elif shellPlay == 1:
		$Audio/shellSound2.play()
	elif shellPlay == 2:
		$Audio/shellSound3.play()
	elif shellPlay == 3:
		await get_tree().create_timer(.6).timeout
		$Audio/shellSound4.play()
	elif shellPlay == 4:
		await get_tree().create_timer(.4).timeout
		$Audio/shellSound5.play()
	elif shellPlay == 5:
		await get_tree().create_timer(.8).timeout
		$Audio/shellSound6.play()


func reloadTimerBewl():
	canReload = false
	await get_tree().create_timer(reloadTime).timeout
	canReload = true

func reload():
	reloadTimer()

func reloadTimer():
	if canReload:
		reloadTimerBewl()
		isReloading = true
		$Audio/reloadSound.play()
		emit_signal("reloading", reloadTime, magSize)
		await get_tree().create_timer(reloadTime).timeout
		magAmt = magSize
		isReloading = false
		needReload = false
		canShoot = true

func shootTimer():
	canShoot = false
	await get_tree().create_timer(STS).timeout
	canShoot = true

func clickTimer():
	canClick = false
	await get_tree().create_timer(STS).timeout
	canClick = true

func invertTimer():
	invT = false
	await get_tree().create_timer(invT_s).timeout
	invT = true


func stepTimer():
	step = false
	await get_tree().create_timer(stepSec).timeout
	step = true


func get_invert():
	var bewl = false
	var carrot = true
	if Input.is_action_pressed("invert"):
		if invT:
			$Audio/invert.play()
			invertTimer()
			emit_signal("inverted", invT_s, invert)
			if invert == 0:
				invert = 1
				bewl = true
			elif invert == 1:
				invert = 0
				bewl = true
	return bewl

var bump = 7

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += bump
	if Input.is_action_pressed('left'):
		input.x -= bump
	if Input.is_action_pressed('down'):
		input.y += bump
	if Input.is_action_pressed('up'):
		input.y -= bump
	return input


func _physics_process(delta):
	#var posiX = $Cam.position
	#print(posiX)
	
	var direction = get_input()
	var invertBool = get_invert()
	if invertBool:
		emit_signal("inverted")
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	aniPlayer()
	stepSounds()
	move_and_slide()

#Walking animation player
#Last-- Right=0  Left=1  Up=2  Down=3
func aniPlayer():
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


func is_moving():
	if abs(velocity.x) > aniCut or abs(velocity.y) > aniCut:
		return true
	return false


func stepSounds():
	if abs(velocity.x) > aniCut or abs(velocity.y) > aniCut:
		if step:
			pass
			#stepTimer()
			#$Audio/stepSound.play()


func _unhandled_input(event):
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("reload"):
		reload()
	if Input.is_action_just_pressed("slow"):
		slow()
	if Input.is_action_just_released("slow"):
		regSpeed()
	if Input.is_action_just_pressed("fast"):
		fast()
	if Input.is_action_just_released("fast"):
		regSpeed()

func shoot():
	
	if magAmt == 0 and not isReloading:
		emit_signal("emptyChamber")
		needReload = true
		canShoot = false
		if canClick:
			clickTimer()
			$Audio/emptyClick.play()

	elif canShoot and not isReloading and not needReload:
			magAmt -= 1
			emit_signal("shotTimer", STS, magAmt)
			var bullet_instance = bullet.instantiate()
			#add_child(bullet_instance)
			get_eg()
			bullet_instance.global_position = egMarker.global_position
			get_bullet_direction()
			bullet_instance.setRot(bullet_angle)
			bullet_instance.setDir(bullet_direction)
			bullet_instance.setInvert(invert)
			shootTimer()
			emit_signal("bulletFired", bullet_instance)
			$Audio/Shoot.play()
			shellHitGround()
			print("pssssst")


func _on_step_finish_black(anim_name):
	if invert == 0:
		if is_moving():
			$Audio/stepSound.play()


func _on_step_finish_white(anim_name):
	if invert == 1:
		if is_moving():
			$Audio/stepSound.play()


func _on_step_start_black(anim_name):
	if invert == 0:
		if is_moving():
			if step:
				stepTimer()
				$Audio/stepSound.play()


func _on_step_start_white(anim_name):
	if invert == 1:
		if is_moving():
			if step:
				stepTimer()
				$Audio/stepSound.play()
