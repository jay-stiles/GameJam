extends Node2D


@onready var bullet_CPU = $bulletCPU
@onready var MrGraye = $MrGraye

signal INVERT()

# Called when the node enters the scene tree for the first time.
func _ready():
	#var bulletShooter = 
	#MrGraye.bulletFired.connect(onShoot)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_mr_graye_bullet_fired(bullet):
	bullet_CPU.bulletShooter(bullet)


func _on_mr_graye_inverted(invT_s, invert):
	emit_signal("INVERT")
