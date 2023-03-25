extends Node2D

var black = Color(255,255,255)
var white = Color(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var invertr = 1
func _on_character_body_2d_inverted():
	print("INVERT")
	if invertr == 0:
		$Background/SimpleBackgroundLayer/PB/PL/CR.color = black
		invertr = 1
	elif invertr == 1:
		$Background/SimpleBackgroundLayer/PB/PL/CR.color = white
		invertr = 0
