extends Label

var dir = randf_range(-150,150)
@onready var endlabel: Timer = $endlabel

func _ready() -> void:
	endlabel.wait_time = randf_range(0.5,0.7)
	endlabel.start()


func _process(delta: float) -> void:
	global_position.x += dir*delta
	global_position.y += -150*delta

func _on_endlabel_timeout() -> void:
	queue_free()
