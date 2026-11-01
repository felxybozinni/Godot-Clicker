extends Control

var prestige = 1000000
@onready var label: Label = $Label
signal upgraded(what,magnitude,prestigecost)

func _process(delta: float) -> void:
	label.text = "prestige: "+str(snapped(prestige,1))
	for i in get_children():
		if i is TextureButton:
			i.prestige = prestige
