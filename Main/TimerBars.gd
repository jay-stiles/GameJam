extends Node

var black = Color(255,255,255)
var white = Color(0,0,0)

@onready var reloadText = $TimerBox/vbReload/hbReload/time
@onready var shotText = $TimerBox/vbShot/hbShot/time
@onready var invertText = $TimerBox/vbInvert/hbInvert/time
@onready var reloadBar = $TimerBox/vbReload/reloadBar
@onready var shotBar = $TimerBox/vbShot/shotBar
@onready var invertBar = $TimerBox/vbInvert/invertBar
@onready var mag = $Magazine/magAmt

var shotProgress = 100
var reloadProgress = 100
var invertProgress = 100
var shot = false
var reload = false
var invert = false
var speedShoot = 4.5
var speedReload = .9
var speedInvert = .6

func _physics_process(delta):
	shotBar.value = shotProgress
	reloadBar.value = reloadProgress
	invertBar.value = invertProgress
	if shot:
		shotProgress += speedShoot
		if shotProgress >=100:
			shot = false
	if reload:
		reloadProgress += speedReload
		if reloadProgress >=100:
			reload = false
	if invert:
		print("INVERT?")
		invertProgress += speedInvert
		if invertProgress >=100:
			invert = false
	

func reloadTimer():
	print("Reloading")
	pass

func shotTimer():
	
	pass

func invertTimer():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	#$TimerBox/vbShot/shotTimer.max_value = 0.4
	$ReloadWarn.visible = false
	pass



func _on_mr_graye_reloading(reloadTime, magSize):
	reloadProgress = 0
	reload = true
	$ReloadWarn.visible = false
	#reloadTimer()
	await get_tree().create_timer(reloadTime).timeout
	mag.text = str(magSize)
	pass # Replace with function body.


func _on_mr_graye_inverted(invT_s, invertr):
	# 0 = black   1 = white
	invertProgress = 0
	invert = true


func _on_mr_graye_shot_timer(STS, magAmt):
	mag.text = str(magAmt)
	if magAmt == 0:
		$ReloadWarn.visible = true
	shotProgress = 0
	shot = true
