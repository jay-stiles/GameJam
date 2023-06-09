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


func _on_mr_graye_player_died():
	get_tree().change_scene_to_file("res://Menus/DeathMenu.tscn")
	


func _on_mr_white_bullet_fired(bullet):
	print("Walter White is attempting to fire a bullet!")
	bullet_CPU.bulletShooter(bullet)


func _on_mr_white_2_bullet_fired(bullet):
	print("Walter White 2 is attempting to fire a bullet!")
	bullet_CPU.bulletShooter(bullet)


func _on_mr_black_bullet_fired(bullet):
	bullet_CPU.bulletShooter(bullet)


func _on_mr_black_2_bullet_fired(bullet):
	bullet_CPU.bulletShooter(bullet)
