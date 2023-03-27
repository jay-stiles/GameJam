extends Node


@onready var hBar = $hbStats/vbHealth/HBoxContainer/healthBar


var hBarPercent = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func changeHealth(currentHealth):
	hBarPercent = currentHealth
	hBar.value = hBarPercent


func _on_mr_graye_changed_health(currentHealth):
	changeHealth(currentHealth)
