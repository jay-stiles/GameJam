extends CharacterBody2D

@export var friction = 0.15
@export var acceleration = 0.1
@export var speed = 200
@export var bullet: PackedScene


@onready var egMarker = $Cam/egR#.position
#var bulletFile = preload("res://Assets/Objects/bullet.tscn")
#var bullet_instance: bullet = bullet.instance()
signal inverted(invT_s, invert)
signal bulletFired(bullet)
signal shotTimer(STS, magAmt)
signal reloading(reloadTime)

var aniCut = 10
# 0 = black   1 = white
var invert = 0

var invT = true
var invT_s = 3
var last = 0

var canShoot = true
var STS = float(0.4)
var bullet_direction = Vector2.ZERO
#	--Away/Up = 0    Right = 90   Left = -90   Down/To = 180
var bullet_angle = 0

var isReloading = false
var magSize = 11
var magAmt = magSize
var reloadTime = 2

var step = true
var stepSec = .30

#gunpoint Marker2D:: Right=0  Left=1  Away/Up=2  To/Down=3
var eg = last


#get gun direction
func get_eg():
	if eg == 0:
		egMarker = $egR#.position
		print("Switching to egR")
		bullet_angle = 90
	elif eg == 1:
		egMarker = $egL#.position
		print("Switching to egL")
		bullet_angle = -90
	elif eg == 2:
		egMarker = $egA#.position
		print("Switching to egA")
		bullet_angle = 0
	elif eg == 3:
		egMarker = $egT#.position
		print("Switching to egT")
		bullet_angle = 180
	print(eg)
	print(egMarker.global_position)


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


func reload():
	reloadTimer()

func reloadTimer():
	isReloading = true
	$Audio/reloadSound.play()
	emit_signal("reloading", reloadTime)
	await get_tree().create_timer(reloadTime).timeout
	magAmt = magSize
	isReloading = false

func shootTimer():
	canShoot = false
	await get_tree().create_timer(STS).timeout
	canShoot = true


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
		if vx > aniCut and vx > vy:
			$Black/BlAni.play("WalkR")
			#$Audio/stepSound.play()
			last = 0
		elif vx < -aniCut and vx < vy:
			$Black/BlAni.play("WalkL")
			last = 1
		elif vy < -aniCut and vy < vx:
			$Black/BlAni.play("WalkAway")
			last = 2
		elif vy > aniCut and vy > vx:
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
		if vx > aniCut and vx > vy:
			$White/WhAni.play("WalkR")
			last = 0
		elif vx < -aniCut and vx < vy:
			$White/WhAni.play("WalkL")
			last = 1
		elif vy < -aniCut and vy < vx:
			$White/WhAni.play("WalkAway")
			last = 2
		elif vy > aniCut and vy > vx:
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

func shoot():
	if canShoot and not isReloading:
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
