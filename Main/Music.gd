extends Node


var state = 0
var rng = RandomNumberGenerator.new()

var paused = false

func playMusic(state):
	match state:
		1:
			$bgm1.play()
			#get_state()
		2:
			$bgm2.play()
			#get_state()
		3:
			$bgm3.play()
			#get_state()
		_:
			get_state()

func get_state():
	state = rng.randi_range(1,3)


# Called when the node enters the scene tree for the first time.
func _ready():
	get_state()
	playMusic(state)


func _on_bgm_1_finished():
	get_state()
	playMusic(state)


func _on_bgm_2_finished():
	get_state()
	playMusic(state)


func _on_bgm_3_finished():
	get_state()
	playMusic(state)


func _on_tm_pressed():
	$OnClick.play()
	if not paused:
		paused = true
		match state:
			1:
				$bgm1.stream_paused = true
				#get_state()
			2:
				$bgm2.stream_paused = true
				#get_state()
			3:
				$bgm3.stream_paused = true
				#get_state()
			_:
				pass
	else:
		paused = false
		match state:
			1:
				$bgm1.stream_paused = false
				#get_state()
			2:
				$bgm2.stream_paused = false
				#get_state()
			3:
				$bgm3.stream_paused = false
				#get_state()
			_:
				pass
