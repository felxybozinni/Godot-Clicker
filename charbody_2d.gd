extends TextureRect
@onready var marker_2d: Marker2D = $Main/Control/Marker2D
var time = 15
@onready var timer: Timer = $Timer
var moving = false
var movingto = true
var startpos
var hassetpos = false
signal click
var changetime = 15
@onready var progress_bar: ProgressBar = $ProgressBar

func _on_timer_timeout() -> void:
	moving = true
	if hassetpos == false:
		startpos = global_position
		hassetpos = true
	timer.start()

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	if moving == true && movingto == true:
		global_position = global_position.move_toward(Vector2(400,150), 300 * delta)
		if global_position.distance_to(Vector2(400,150)) < 10:
			movingto = false
			click.emit()
	else:
		if moving == true && movingto == false:
			global_position = global_position.move_toward(startpos, 300 * delta)
			if global_position.distance_to(startpos) < 10:
				moving = false
				movingto = true
	time = changetime
	timer.wait_time = time
	
	progress_bar.value = timer.time_left/ timer.wait_time
