extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_main_invert():
	get_tree().call_group("FTIB", "flip")
	get_tree().call_group("FTIW", "flip")


func _on_door_2_move_to_next():
	$Audio/Win.play()
	await get_tree().create_timer(.3).timeout
	get_tree().change_scene_to_file("res://Menus/WinMenu.tscn")


func _on_mr_white_enemy_died():
	$Audio/EnemyDie.play()


func _on_mr_white_2_enemy_died():
	$Audio/EnemyDie.play()


func _on_mr_black_enemy_died():
	$Audio/EnemyDie.play()


func _on_mr_black_2_enemy_died():
	$Audio/EnemyDie.play()
