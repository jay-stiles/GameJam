extends Node2D

@onready var DZsmall = $DZsmall
@onready var DZbig = $DZbig
@onready var DZmed = $DZmed

@onready var egMarker = null
@onready var egr: Marker2D
@onready var egl: Marker2D
@onready var ega: Marker2D
@onready var egt: Marker2D

@export var bullet: PackedScene
@export var walkSpeed = 80

signal stateChanged(state)
signal fireBullet(bullet)
signal getInfo()
signal moveToPlayer(dirToPlayer, velocity, speed, acceleration, friction)
signal psstR()
signal psstL()
signal psstA()
signal psstT()
#  0 = regular,  1 = attack
var State = 0 
var player: Player = null
var enemy: Enemy = null

var invert = 1

func SBB():
	invert = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("getInfo")

func starter(enemy):
	self.enemy = enemy

func receiveInfo(egr, egl, ega, egt):
	self.egr = egr
	self.egl = egl
	self.ega = ega
	self.egt = egt
	egMarker = egr

var enemyDir = null
var vecToPlayer = Vector2.ZERO
var dirToPlayer = Vector2()
var distanceToPlayer = 0
var curPos = Vector2.ZERO
var playerPos = Vector2.ZERO

func getPosPlayer():
	playerPos = player.global_position
	#print("playerPos (Player) = ", playerPos)

func getPosEnemy():
	curPos = enemy.global_position
	#print("curPos (enemy) = ", curPos)

func getDirToPlayer():
	getPosEnemy()
	getPosPlayer()
	vecToPlayer = playerPos - curPos
	dirToPlayer = vecToPlayer.angle()
	distanceToPlayer = vecToPlayer.length()
	#print("vecToPlayer... = ", vecToPlayer)
	#print("dirToPlayer... ... ... = ", dirToPlayer)
	#print("Distance from player... = ", distanceToPlayer)
	#dirToPlayer = 

var ableToShoot = true
var ableToShoot2 = true
var shootCooldown = 2
var bullet_angle = 0
var rng = RandomNumberGenerator.new()

func fireTimer():
	shootCooldown = rng.randi_range(1, 3)
	ableToShoot = false
	await get_tree().create_timer(shootCooldown).timeout
	ableToShoot = true

func fireTimer2():
	shootCooldown = rng.randi_range(1, 3)
	ableToShoot2 = false
	await get_tree().create_timer(shootCooldown*1.3).timeout
	ableToShoot2 = true

func attemptFire():
	if ableToShoot:
		fireTimer()
		getDirToPlayer()
		shoot()
		

func moveTowardsPlayer():
	getDirToPlayer()
	var velocity = Vector2.ZERO
	var speed = 80
	var acceleration = 0.1
	var friction = 0.15
	if dirToPlayer != null:
		velocity = velocity.lerp(vecToPlayer.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	emit_signal("moveToPlayer", vecToPlayer, velocity, speed, acceleration, friction)
	#aniEnemy()
	#stepSounds()
	#move_and_slide()


func _physics_process(delta):
	match State:
		0:
			pass
		1:
			moveTowardsPlayer()
			attemptFire()
		_:
			pass

func changeState(newState):
	if State == newState:
		return
	State = newState
	emit_signal("stateChanged")

var eg = 0

func getEG(EG):
	eg = EG

var particleTime = .2

func get_eg():
	if eg == 0:
		egMarker = egr
		bullet_angle = 90
		emit_signal("psstR")
		#$egR/psst.emitting = true
		#await get_tree().create_timer(particleTime).timeout
		#$egR/psst.emitting = false
	elif eg == 1:
		egMarker = egl
		bullet_angle = -90
		emit_signal("psstL")
		#$egL/psst.emitting = true
		#await get_tree().create_timer(particleTime).timeout
		#$egL/psst.emitting = false
	elif eg == 2:
		egMarker = ega
		bullet_angle = 0
		emit_signal("psstA")
		
	elif eg == 3:
		egMarker = egt
		bullet_angle = 180
		emit_signal("psstT")
		
	#print(eg)
	#print(egMarker.global_position)

var bullet_direction = Vector2.ZERO
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

"""func get_eg():
	pass"""



func shoot():
	if ableToShoot2:
		var bullet_instance = bullet.instantiate()##
		#add_child(bullet_instance)
		get_eg()
		bullet_instance.global_position = egMarker.global_position
		get_bullet_direction()
		bullet_instance.setRot(bullet_angle)
		bullet_instance.setDir(bullet_direction)
		bullet_instance.setInvert(invert)
		fireTimer2()
		fireTimer()
		emit_signal("fireBullet", bullet_instance)
		$Audio/Shoot.play()
		#shellHitGround()
		print("pssssst")


func _on_d_zsmall_body_entered(body):
	if body.is_in_group("player"):
		changeState(1)
		player = body


func _on_d_zmed_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if player.speed >= 200:
			changeState(1)
		else:
			print("Must have been my imagination...")
			pass
		#player = body


func _on_d_zbig_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if player.speed > 200:
			changeState(1)
			print("WOW! I heard you coming from a mile away!")
		#player = body
