extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_area_2d_area_entered(area):
	if area.has_method("removerWall"):
		area.removerWall()
		$Audio/impactWall.play()
