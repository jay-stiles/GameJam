extends CharacterBody2D

@onready var brain = $Brain

func _ready():
	await get_tree().create_timer(1).timeout
	brain.SBB()
	pass
