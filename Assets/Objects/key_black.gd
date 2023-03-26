extends Node2D


signal keyBlackConnected()



func _on_key_area_body_entered(body):
	if body.has_method("shoot"):
		emit_signal("keyBlackConnected")
		queue_free()
