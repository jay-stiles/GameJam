extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#antiquated
func _on_area_2d_body_entered(body):
	#print("WallEntered")
	if body.has_method("removerWall"):
		body.removerWall()


func _on_area_2d_area_entered(area):
	#print("WallEnteredArea")
	if area.has_method("removerWall"):
		area.removerWall()
		$Audio/impactWall.play()
