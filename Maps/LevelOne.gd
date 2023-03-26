extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_main_invert():
	print("Flipping Command sent....")
	get_tree().call_group("FTIB", "flip")
	get_tree().call_group("FTIW", "flip")
