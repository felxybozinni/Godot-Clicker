extends Control

#welcome to my code. I've tried my best to keep it legible, but I'm not very good with that, haha! some of the function names are a bit confusing. This project is written entirely in GDScript, 
#except for the web stuff, of course! The web stuff is handled automatically by Godot (JavaScript and HTML) and the YML is from Github, so I did not write those files. I love Godot.

#ints
var value = 99999999999999
var incval = 1
var boughtups = 0
var cost = 5
var percycle = 1
var cyclelength = 10
var newcharbodycost = 1000
var char2ds = 0
#bools
var hasshop = false
var hasnode2D = false
var node2disinshop = false
var unlockedchar2d = false
#arrays
var nouns = ["keyboard","mouse","screen","pixels","fingers","files","strings","coding","servers","CPUs","cooling","GPUs","circuits","motherboard","buttons"]
var adjectives = ["Efficient","Quicker","Speedy","Overloaded","Unravelled","Incredible","Optimised","Sponsored","Heated"]
var inshop = []
var inshoptype = []
#textures
const CONTROLICON = preload("res://assets/Controlicon.png")
const NODEICON = preload("res://assets/Nodeicon.png")
const TIMERICON = preload("uid://dvwcwji8spja3")
const CHARACTERBODY2DICON = preload("uid://dmx07nteigwxe")

#nodes
@onready var valdisp: Label = $Main/infobox/valdisp
@onready var shop: CanvasLayer = $Main/Shop
@onready var node_2d: CenterContainer = $Main/Node2D
@onready var item_list: ItemList = $Main/Shop/ItemList
@onready var node_2_dtime: Timer = $Main/Node2D/node2dtime
@onready var node_2_dbar: TextureProgressBar = $Main/Node2D/node2dbar
@onready var idledisp: Label = $Main/infobox/idledisp
@onready var control: CenterContainer = $Main/Control
@onready var main: Control = $"."
@onready var mainlayer: CanvasLayer = $Main
@onready var item_list_character_2d: ItemList = $Main/Shop/ItemListCharacter2D
@onready var option_button: OptionButton = $Main/Shop/OptionButton
@onready var notifier: Label = $Main/Shop/Notifier
@onready var showlength: Timer = $Main/Shop/Notifier/Showlength
@onready var notifprog: ProgressBar = $Main/Shop/Notifier/Notifprog
@onready var path_follow_2d: PathFollow2D = $Main/Control/Path2D/PathFollow2D
@onready var char_2_ds: CanvasLayer = $Main/Char2ds
@onready var numbers: CanvasLayer = $Main/numbers
@onready var marker_2d: Marker2D = $Main/Control/Marker2D

#tcsns
const MONEYNUMBER = preload("uid://jiv5qp3e1dn6")
const CHARBODY_2D = preload("uid://4p2s52kgbnh1")

func controlpressed() -> void:
	value += incval
	var instance = MONEYNUMBER.instantiate()
	numbers.add_child(instance)
	if instance.global_position == Vector2(0,0):
		instance.text = "+"+str(snapped(incval,0.1))
		instance.global_position = Vector2(randf_range(350,450),150)

func _process(delta: float) -> void:
	valdisp.text = "Hackatime minutes: "+str(snapped(value,0.1))
	if value >= 10 && hasshop == false:
		shop.show()
	node_2_dbar.value = (node_2_dtime.time_left / node_2_dtime.wait_time) * 100
	idledisp.text = str(snapped(percycle,0.1))+" per "+str(snapped(cyclelength,0.01))+"s"
	if unlockedchar2d == false && value >= 500:
		unlockedchar2d = true
		option_button.add_icon_item(CHARACTERBODY2DICON,"CharacterBody2D",1)
		notify()
	notifprog.value = (showlength.time_left / showlength.wait_time) * 100

func _ready() -> void:
	addrandshopitem()

func addrandshopitem():
	var output : String
	output = str(adjectives[randf_range(0,adjectives.size())])+" "+str(nouns[randf_range(0,nouns.size())]+" "+str(cost)+" minutes")
	boughtups += 1
	cost = cost + ((boughtups^2)*0.1)
	cost = snapped(cost,0.01)
	if hasnode2D == true && randi_range(0,2) != 0:
		if randi_range(0,1) == 1:
			item_list.add_item(output,NODEICON)
			inshop.append(cost)
			inshoptype.append("node2")
		else:
			item_list.add_item(output,TIMERICON)
			inshop.append(cost)
			inshoptype.append("timer")
			
	else:
		item_list.add_item(output,CONTROLICON)
		inshop.append(cost)
		inshoptype.append("control")
		return output
func _on_node_2_dtime_timeout() -> void:
	if hasnode2D == true:
		value += percycle
		node_2_dtime.wait_time = cyclelength
		var instance = MONEYNUMBER.instantiate()
		numbers.add_child(instance)
		if instance.global_position == Vector2(0,0):
			instance.text = "+"+str(snapped(percycle,0.1))
			instance.global_position = Vector2(randf_range(350,450),500)


func _on_item_list_item_selected(index: int) -> void:
	var price = inshop[index]
	if price == -1:
		if value >= 50:
			value -= price
			node_2d.show()
			hasnode2D = true
			percycle = 1
			cyclelength = 10
			item_list.remove_item(index)
			inshop.remove_at(inshop.find(-1))
			node_2_dtime.wait_time = 10
			node_2_dtime.start()
			idledisp.show()
		else:
			item_list.deselect_all()
	if value >= price && price > 0:
		if inshoptype [index] == "control":
			incval *= randf_range(1.05,1.25)
		else:
			if inshoptype [index] == "node2":
				percycle *= randf_range(1.1,1.3)
			else:
				if inshoptype [index] == "timer":
					cyclelength *= randf_range(0.95,0.89)
		value -= price
		item_list.remove_item(index)
		inshop.remove_at(index)
		inshoptype.remove_at(index)
		if item_list.item_count <=7:
			addrandshopitem()
		addrandshopitem()
		if boughtups >= 10 && hasnode2D == false && node2disinshop == false:
			item_list.add_item("Node2D 50 minutes",NODEICON)
			node2disinshop = true
			inshop.append(-1)
	else:
		item_list.deselect_all()


func _new_tab(index: int) -> void:
	if index == 0:
		item_list.show()
		item_list_character_2d.hide()
	if index == 1:
		item_list.hide()
		item_list_character_2d.show()

func notify():
	notifier.show()
	showlength.start()

func _on_showlength_timeout() -> void:
	notifier.hide()


func _on_closenotif_pressed() -> void:
	notifier.hide()


func _on_item_list_character_2d_item_selected(index: int) -> void:
	if index == 0:
		if value >= newcharbodycost:
			value -= newcharbodycost
			char2ds += 1
			newcharbodycost *= 4
			var instance = CHARBODY_2D.instantiate()
			instance.texture = CHARACTERBODY2DICON
			print(char2ds)
			char_2_ds.add_child(instance)
			instance.global_position = path_follow_2d.global_position
			path_follow_2d.progress_ratio = char2ds * 0.05
			instance.rotation = (marker_2d.global_position - instance.global_position).angle()
			instance.rotation_degrees += 90
			item_list_character_2d.set_item_text(0,"New Character2D "+str(newcharbodycost)+" minutes")
			item_list_character_2d.deselect_all()
