extends CanvasLayer

var state = false

var fullscreen = false



func _on_pause():
	if self.visible == false:
		$OnClick.play()
		self.visible = true
		$ColorRect/Text/TextBox.visible = true
		get_tree().paused = true
	else:
		self.visible = false
		$ColorRect/Text/TextBox.visible = false
		get_tree().paused = false



func _on_button_mouse_entered():
	$OnLook.play()


func _on_res_pressed():
	$OnClick.play()
	await get_tree().create_timer(.3).timeout
	_on_pause()
	#get_tree().paused = false


func _on_tf_pressed():
	$OnClick.play()
	if not fullscreen:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = false


func _on_exit_pressed():
	$OnClick.play()
	await get_tree().create_timer(.3).timeout
	get_tree().quit()


func _on_mm_pressed():
	$OnClick.play()
	await get_tree().create_timer(.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
