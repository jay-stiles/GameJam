extends CharacterBody2D
#WALTUH
class_name Enemy

@export var aniFrame = 0
@export var health = 60
@export var bullet: PackedScene

@onready var brain = $Brain

signal struckByBullet()
signal bulletFired(bullet)

func _ready():
	brain.starter(self)


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
