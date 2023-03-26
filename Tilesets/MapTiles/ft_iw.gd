extends Node2D

###
###   ###   INITIALLY WHITE TILES
###
var white = Color(255,255,255)
var black = Color(0,0,0)

# STATE 0 = White  :: STATE 1 = Black
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func flip():
	print("Flipping")
	if state == 1:
		$C/ColorRect.color = white
		state = 0
	else:
		$C/ColorRect.color = black
		state = 1
