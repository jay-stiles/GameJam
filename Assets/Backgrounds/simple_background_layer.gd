extends Node2D

var white = Color(255,255,255)
var black = Color(0,0,0)

# STATE 0 = White  :: STATE 1 = Black
var state = 0


func flip():
	print("Flipping")
	if state == 1:
		$PB/PL/CR.color = white
		state = 0
	else:
		$PB/PL/CR.color = black
		state = 1
