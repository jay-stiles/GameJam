extends Node2D

@onready var DZsmall = $DZsmall
@onready var DZbig = $DZbig
@onready var DZmed = $DZmed

@export var walkSpeed = 80

signal stateChanged(state)

#  0 = regular,  1 = attack
var State = 0 
var player: Player = null
var enemy: Enemy = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func starter(enemy):
	self.enemy = enemy

var enemyDir = null
var dirToPlayer = Vector2()
var curPos = Vector2.ZERO
var playerPos = Vector2.ZERO

func getPosPlayer():
	playerPos = player.global_position
	print("playerPos (Player) = ", playerPos)

func getPosEnemy():
	curPos = enemy.global_position
	print("curPos (enemy) = ", curPos)

func getDirToPlayer():
	getPosEnemy()
	getPosPlayer()
	#dirToPlayer = 

var ableToShoot = true
var shootCooldown = 1.2


func fireTimer():
	ableToShoot = false
	await get_tree().create_timer(shootCooldown).timeout
	ableToShoot = true

func attemptFire():
	if ableToShoot:
		fireTimer()
		getDirToPlayer()
		

func moveTowardsPlayer():
	pass


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
