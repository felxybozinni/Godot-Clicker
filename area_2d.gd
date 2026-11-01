extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


func _on_main_changeshape() -> void:
	collision_shape_2d.disabled = true
	collision_polygon_2d.disabled = false
