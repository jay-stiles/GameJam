extends Node

var black = Color(255,255,255)
var white = Color(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerBox/vbShot/shotTimer.max_value = 0.4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mr_graye_reloading(reloadTime):
	pass # Replace with function body.


func _on_mr_graye_inverted(invT_s, invert):
	# 0 = black   1 = white
	"""
	if invert == 0:
		$TimerBox/hbShot/shotTimer.add_theme_color_override(ba)
		#self.get("theme_override_styles/background").set_
		#$TimerBox/hbShot/shotTimer.theme_override_styles/background = black
	elif invert == 1:
		#$TimerBox/hbShot/shotTimer.fill = white
		pass
	"""
	pass


func _on_mr_graye_shot_timer(STS, magAmt):
	pass # Replace with function body.
