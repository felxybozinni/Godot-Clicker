extends RigidBody2D

signal collidevent(x,y)
@onready var progress_bar: ProgressBar = $ProgressBar
var progress = 0

func _process(delta: float) -> void:
	progress_bar.value = progress

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("rigidbody"):
		collidevent.emit(global_position.x,global_position.y)

func applyforce():
	linear_velocity = Vector2(randf_range(300,-300),randf_range(-1000,200))
	angular_velocity = randf_range(30,-30)
