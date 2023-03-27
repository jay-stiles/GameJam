extends Node2D

signal moveToNext()



func _on_door_area_body_entered(body):
	if body.has_method("fast"):
		emit_signal("moveToNext")


func _on_key_black_key_black_connected():
	$DoorSprite.visible = true
	$DoorArea.monitoring = true
