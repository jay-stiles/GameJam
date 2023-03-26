extends Node2D


# Called when the node enters the scene tree for the first time.

signal keyWhiteConnected()



func _on_key_area_body_entered(body):
	if body.has_method("shoot"):
		emit_signal("keyWhiteConnected")
		queue_free()

