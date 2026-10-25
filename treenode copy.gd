extends TextureButton

@export var icon: CompressedTexture2D
var purchased = false
@export var cost = 0
@onready var line_2d: Line2D = $Line2D
@export var what = ""
@export var value = 0.0

func _ready() -> void:
	hide()
	texture_normal = icon
	if get_parent() is TextureButton:
		line_2d.add_point(global_position)
		line_2d.add_point(get_parent().global_position)

func _on_pressed() -> void:
	if purchased == false:
		if owner.prestige >= cost:
			self_modulate = Color(1,1,1,1)
			line_2d.default_color = Color(0.397, 0.518, 0.201, 1.0)
			purchased = true
			owner.upgraded.emit(what,value,cost)
			
func _process(delta: float) -> void:
	if get_parent() is TextureButton:
		if get_parent().purchased == true:
			show()
	else:
		show()
