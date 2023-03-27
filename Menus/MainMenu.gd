extends Control

var white = Color(255,255,255)
var black = Color(0,0,0)
var invertState = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MMC/MrGrayeB.visible = false
	$MMC/MrGrayeW.visible = true



func _on_invert_pressed():
	flip()



# STATE 0 = White  :: STATE 1 = Black



func flip():
	#print("Flipping")
	if invertState == 0:
		$MMC/ColorRect.color = white
		$MMC/MrGrayeW.visible = false
		$MMC/MrGrayeB.visible = true
		invertState = 1
		$Music/invert.play()
	else:
		$MMC/ColorRect.color = black
		$MMC/MrGrayeB.visible = false
		$MMC/MrGrayeW.visible = true
		invertState = 0
		$Music/invert.play()

var fullscreen = true

func _on_tf_pressed():
	var size = Vector2()
	size.x = 1728
	size.y = 972
	$MMC/OnClick.play()
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
	#$MMC/OnClick.pitch_scale = .7
	$MMC/OnClick.play()
	await get_tree().create_timer(.4).timeout
	get_tree().quit()

func _on_skip_pressed():
	$Music/StartSound.play()
	await get_tree().create_timer(.4).timeout
	get_tree().change_scene_to_file("res://Maps/LevelTwo.tscn")

func _on_start_pressed():
	$Music/StartSound.play()
	await get_tree().create_timer(.4).timeout
	get_tree().change_scene_to_file("res://Maps/LevelOne.tscn")

func _on_start_mouse_entered():
	$MMC/OnLook.play()


func _on_skip_mouse_entered():
	$MMC/OnLook.play()


func _on_tf_mouse_entered():
	$MMC/OnLook.play()


func _on_exit_mouse_entered():
	$MMC/OnLook.play()


func _on_invert_button_2_pressed():
	flip()
