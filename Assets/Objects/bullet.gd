extends Area2D

class_name Bullet

@export var SPEED = 18
var direction := Vector2.ZERO
var inverter = 0
var angle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * SPEED
		global_position += velocity


func setDir(direction: Vector2):
	self.direction = direction

func setInvert(invertr):
	#black == 0; white == 1
	if invertr == 0:
		$bulletW.visible = false
		$bulletB.visible = true
	elif invertr == 1:
		$bulletW.visible = true
		$bulletB.visible = false


func setRot(deg):
	rotation_degrees = deg

func removerWall():
	#emit_signal()
	queue_free()



func hitByBullet():
	pass

func _on_body_entered(body):
	if body.has_method("enemyFunction"):
		hitByBullet()
	if body.has_method("playerFunction"):
		hitByBullet()
