extends Node2D




func _on_door_area_body_entered(body):
	if body.has_method("fast"):
		print("MOVING TO LEVEL 2")


func _on_key_black_key_black_connected():
	$DoorSprite.visible = true
	$DoorArea.monitoring = true
