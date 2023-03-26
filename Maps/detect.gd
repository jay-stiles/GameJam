extends Node




func _on_area_2d_body_entered(body):
	if body.has_method("shoot"):
		$instruct1.visible = true


func _on_second_area_body_entered(body):
	if body.has_method("shoot"):
		$instruct2.visible = true
