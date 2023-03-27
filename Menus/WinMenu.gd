extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()




func _on_mm_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")

var fullscreen = true
func _on_tf_pressed():
	var size = Vector2()
	size.x = 1728
	size.y = 972
	if fullscreen == false:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		await get_tree().create_timer(.2).timeout
		DisplayServer.window_set_size(size)
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = false


func _on_exit_pressed():
	get_tree().quit()
