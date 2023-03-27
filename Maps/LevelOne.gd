extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_main_invert():
	#print("Flipping Command sent....")
	get_tree().call_group("FTIB", "flip")
	get_tree().call_group("FTIW", "flip")


func _on_door_move_to_next():
	$Win.play()
	get_tree().change_scene_to_file("res://Maps/LevelTwo.tscn")
