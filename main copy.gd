extends Control

#welcome to my code. I've tried my best to keep it legible, but I'm not very good with that, haha! some of the function names are a bit confusing. This project is written entirely in GDScript, 
#except for the web stuff, of course! The web stuff is handled automatically by Godot (JavaScript and HTML) and the YML is from Github, so I did not write those files. I love Godot.
#I hope you enjoy the game! I'm planning on updating this for futurre weeks as well, so I'm pretty hyped for that. Can't wait, this is my first hack club event!
#I'm geniunely so proud of this project. The prestige system especially I'm happy with! I can't believe what code is capable, even with an amateur like me! Thanks Hack Club!
#It's not HEAVILY tested, so it might not be fully stable, but don't do anything crazy. Autoclickers should be fine! The prestige tab of the shop has a money hack you can test with.

#ints
var value = 0
var incval = 1
var boughtups = 0
var cost = 5
var percycle = 1
var cyclelength = 10
var newcharbodycost = 1000
var char2ds = 0
var decchartimecost = 10000
var mult2dcharcost = 5000
var char2dmult = 1
var changetime = 15
var newrigidbodycost = 25000
var rigidbodies = 0
var decrigtimecost = 40000
var profrigcost = 50000
var profrigmult = 5
var newtextrectcost = 100000
var textrects = 0
var dectexttimecost = 150000
var textprofcost = 150000
var textmult = 10
var newcolorrectcost = 3000000
var colorrects = 0
var deccolortimecost = 10000000
var colorprofcost = 30000000
var colormult = 40
var area2dcost = 500000000
var enlargearea2dcost = 1000000000
var areaprofcost = 800000000
var areamult = 100
var prestigeamount = 0
var prestige = 0
var universal_bonus = 1.0
var control_bonus = 1.0
var char2d_bonus = 1.0
var rigid_bonus = 1.0
var area_bonus = 1.0
var textu_bonus = 1.0
var colo_bonus = 1.0
var char2dtime_bonus = 1.0
var rigidtime_bonus = 1.0
var prest_bonus = 1.0
var prestm_bonus = 1.0
var colot_bonus = 1.0
var colou = 1.0
var textut_bonus = 1.0
#bools
var hasshop = false
var hasnode2D = false
var node2disinshop = false
var unlockedchar2d = false
var unlockedrigbod2d = false
var unlockedtextrect = false
var maxrects = false
var unlockedcolorrect = false
var hasarea2d = false
var unlockedarea2d = false
#constants
const MAXNUMBS = 100
#arrays
var nouns = ["keyboard","mouse","screen","pixels","fingers","files","strings","coding","servers","CPUs","cooling","GPUs","circuits","motherboard","buttons","cables","agents","funding","music","hardware","projects","editor","coding language","system"]
var adjectives = ["Efficient","Quicker","Speedy","Overloaded","Unravelled","Incredible","Optimised","Sponsored","Heated","Cooled","Supreme","Upgraded","Fanned","Loud","Muted","Numerous","Unbelievable","Holy","Open source","Proprietary"]
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
@onready var item_list: ItemList = $"Main/Shop/FoldableContainer/TabContainer/Basic upgrades"
@onready var node_2_dtime: Timer = $Main/Node2D/node2dtime
@onready var node_2_dbar: TextureProgressBar = $Main/Node2D/node2dbar
@onready var idledisp: Label = $Main/infobox/idledisp
@onready var control: CenterContainer = $Main/Control
@onready var main: Control = $"."
@onready var mainlayer: CanvasLayer = $Main
@onready var item_list_character_2d: ItemList = $Main/Shop/FoldableContainer/TabContainer/Characterbody2D
@onready var notifier: Label = $Main/Shop/Notifier
@onready var showlength: Timer = $Main/Shop/Notifier/Showlength
@onready var notifprog: ProgressBar = $Main/Shop/Notifier/Notifprog
@onready var path_follow_2d: PathFollow2D = $Main/Control/Path2D/PathFollow2D
@onready var char_2s: Node2D = $Main/char2s
@onready var numbers: CanvasLayer = $Main/numbers
@onready var marker_2d: Marker2D = $Main/Control/Marker2D
@onready var tab_container: TabContainer = $Main/Shop/FoldableContainer/TabContainer
@onready var clicksound: AudioStreamPlayer2D = $Main/clicksound
@onready var rigidbody_2dlist: ItemList = $Main/Shop/FoldableContainer/TabContainer/Rigidbody2D
@onready var rigidbodytimer: Timer = $Main/rigidbodytimer
@onready var texturerectlist: ItemList = $Main/Shop/FoldableContainer/TabContainer/Texturerect
@onready var textrecttimer: Timer = $Main/Textrecttimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var colorrectlist: ItemList = $Main/Shop/FoldableContainer/TabContainer/ColorRect
@onready var colorrecttimer: Timer = $Main/ColorRectTimer
@onready var area_2d: ItemList = $Main/Shop/FoldableContainer/TabContainer/Area2D
@onready var foreground: CanvasLayer = $Foreground
@onready var area2d: Area2D = $Foreground/Area2D
@onready var prestigelabel: Label = $Main/Shop/FoldableContainer/TabContainer/Prestige/Prestigelabel
@onready var confirm: CanvasLayer = $Foreground/Confirm
@onready var prestigelabel_2: Label = $Main/Shop/FoldableContainer/TabContainer/Prestige/Prestigelabel2
@onready var background: CanvasLayer = $Background
@onready var treeroot: Control = $Treeroot

#tcsns
const MONEYNUMBER = preload("uid://jiv5qp3e1dn6")
const CHARBODY_2D = preload("uid://4p2s52kgbnh1")
const RIGIDBODY = preload("uid://6x7yqyb3navh")
const TEXTURERECT = preload("uid://d2ye7qem4tea")
const COLORRECT = preload("uid://cnpiotg1ceocq")
const AREA_2D = preload("uid://clunjcsrl5vau")

#signals
signal forceapply
signal changeshape

func controlpressed():
	value += incval * universal_bonus * control_bonus
	var instance = MONEYNUMBER.instantiate()
	numbers.add_child(instance)
	if instance.global_position == Vector2(0,0):
		if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
			pass
		else:
			instance.text = "+"+str(snapped(incval*universal_bonus*control_bonus,0.1))
			instance.global_position = Vector2(randf_range(200,600),150)
		clicksound.play()

func _process(_delta: float) -> void:
	valdisp.text = "Hackatime minutes: "+str(snapped(value,0.1))
	if value >= 10 && hasshop == false:
		shop.show()
	node_2_dbar.value = (node_2_dtime.time_left / node_2_dtime.wait_time) * 100
	idledisp.text = str(snapped(percycle,0.1))+" per "+str(snapped(cyclelength,0.01))+"s"
	if unlockedchar2d == false && value >= 500:
		unlockedchar2d = true
		tab_container.set_tab_hidden(1,false)
		notify()
	if unlockedrigbod2d == false && value >= 10000:
		unlockedrigbod2d = true
		tab_container.set_tab_hidden(2,false)
		notify()
	if unlockedtextrect == false && value >= 65000:
		unlockedtextrect = true
		tab_container.set_tab_hidden(3,false)
		notify()
	if unlockedcolorrect == false && value >= 1500000:
		unlockedcolorrect = true
		tab_container.set_tab_hidden(4,false)
		notify()
	if unlockedarea2d == false && value >= 400000000:
		unlockedarea2d = true
		tab_container.set_tab_hidden(5,false)
		notify()
	notifprog.value = (showlength.time_left / showlength.wait_time) * 100
	get_tree().call_group("char2dbody","set","changetime",changetime*char2dtime_bonus)
	get_tree().call_group("rigidbody","set","progress",rigidbodytimer.time_left / rigidbodytimer.wait_time)
	get_tree().call_group("textrects","set","prog",textrecttimer.time_left / textrecttimer.wait_time)
	prestigeamount = (snapped(value,10000000000.0)/10000000000)+snapped((rigidbodies/4.0),1)+snapped((textrects/5.0),1)+snapped((colorrects/3.0),1)
	if hasarea2d == true:
		prestigeamount += 10
	prestigelabel.text = "Resseting will give you "+str(snapped(prestigeamount*prest_bonus,1))+" prestige!"
	prestigelabel_2.text = "Total current prestige: "+str(snapped(prestige,1))+" prestige"
	universal_bonus = 1 + (prestige * 0.001 * prestm_bonus)
	treeroot.prestige = prestige

func _ready() -> void:
	addrandshopitem()

func addrandshopitem():
	var output : String
	output = str(adjectives[randf_range(0,adjectives.size())])+" "+str(nouns[randf_range(0,nouns.size())]+" "+str(cost)+" minutes")
	boughtups += 1
	cost = cost + ((boughtups^5)*0.25)
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
		node_2_dtime.start()
		var instance = MONEYNUMBER.instantiate()
		numbers.add_child(instance)
		if instance.global_position == Vector2(0,0):
			if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
				pass
			else:
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
			incval *= randf_range(1.08,1.25)
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
		if item_list.item_count <=10:
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
			char_2s.add_child(instance)
			instance.global_position = path_follow_2d.global_position
			path_follow_2d.progress_ratio = char2ds * 0.05
			instance.rotation = (marker_2d.global_position - instance.global_position).angle()
			instance.rotation_degrees += 90
			instance.add_to_group("char2dbody")
			instance.connect("click",Callable(self,"controlpressed2d"))
			item_list_character_2d.set_item_text(0,"New Character2D "+str(newcharbodycost)+" minutes")
			item_list_character_2d.deselect_all()
		else:
			item_list_character_2d.deselect_all()
	if index == 1:
		if value >= decchartimecost:
			value -= decchartimecost
			changetime *= 0.9
			get_tree().call_group("char2dbody","set","changetime",changetime)
			item_list_character_2d.deselect_all()
			decchartimecost *= 3
			item_list_character_2d.set_item_text(1,"Decrease wait time "+str(decchartimecost)+" minutes")
	if index == 2:
		if value >= mult2dcharcost:
			value -= mult2dcharcost
			char2dmult *= 1.5
			item_list_character_2d.deselect_all()
			mult2dcharcost *= 9
			item_list_character_2d.set_item_text(2,"Multiplier "+str(mult2dcharcost)+" minutes")
	item_list_character_2d.deselect_all()

func controlpressed2d():
	value += incval * universal_bonus * char2dmult * control_bonus * char2d_bonus
	var instance = MONEYNUMBER.instantiate()
	numbers.add_child(instance)
	if instance.global_position == Vector2(0,0):
		if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
			pass
		else:
			instance.text = "+"+str(snapped(incval * char2dmult * universal_bonus * control_bonus * char2d_bonus,0.1))
			instance.global_position = Vector2(randf_range(200,600),150)


func _on_rigidbody_2d_item_selected(index: int) -> void:
	if index == 0:
		if value >= newrigidbodycost:
			value -= newrigidbodycost
			rigidbodies += 1
			newrigidbodycost *= 7
			for i in 3:
				var instance = RIGIDBODY.instantiate()
				mainlayer.add_child(instance)
				instance.global_position = Vector2(randf_range(50,750),randf_range(50,600))
				instance.add_to_group("rigidbody")
				instance.collidevent.connect(rigidbodycollided)
				connect("forceapply",Callable(instance,"applyforce"))
			rigidbody_2dlist.set_item_text(0,"New RigidBody2Ds "+str(newrigidbodycost)+" minutes")
			rigidbody_2dlist.deselect_all()
		else:
			rigidbody_2dlist.deselect_all()
	if index == 1:
		if value >= decrigtimecost:
			value -= decrigtimecost
			rigidbodytimer.wait_time *= 0.8
			decrigtimecost *= 3.5
			rigidbody_2dlist.set_item_text(1,"Decrease force interval "+str(decrigtimecost)+" minutes")
	if index == 2:
		if value >= profrigcost:
			value -= profrigcost
			profrigmult *= 1.5
			profrigcost *= 6
			rigidbody_2dlist.set_item_text(2,"Increase collision payout "+str(profrigcost)+" minutes")
	rigidbody_2dlist.deselect_all()

func rigidbodycollided(x,y):
	value += incval * universal_bonus * profrigmult * rigid_bonus
	var instance = MONEYNUMBER.instantiate()
	numbers.add_child(instance)
	if instance.global_position == Vector2(0,0):
		if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
			pass
		else:
			instance.text = "+"+str(snapped(incval*profrigmult*rigid_bonus*universal_bonus,0.1))
			instance.global_position = Vector2(x,y)

func _on_rigidbodytimer_timeout() -> void:
	forceapply.emit()


func _on_texturerectlist_item_selected(index: int) -> void:
	if index == 0:
		if value >= newtextrectcost:
			if maxrects == false:
				value -= newtextrectcost
				newtextrectcost *= 3.5
				var instance = TEXTURERECT.instantiate()
				mainlayer.add_child(instance)
				instance.global_position = Vector2((textrects*80)+270,10)
				textrects += 1
				instance.add_to_group("textrects")
				if textrects >= 8:
					texturerectlist.set_item_text(0,"limit reached")
					maxrects = true
				else:
					texturerectlist.set_item_text(0,"New TextureRect "+str(newtextrectcost)+" minutes")
				texturerectlist.deselect_all()
			else:
				texturerectlist.deselect_all()
	if index == 1:
		if value >= dectexttimecost:
			value -= dectexttimecost
			textrecttimer.wait_time *= 0.8
			dectexttimecost *= 3.5
			texturerectlist.set_item_text(1,"Decrease Cycle Time "+str(dectexttimecost)+" minutes")
	if index == 2:
		if value >= textprofcost:
			value -= textprofcost
			textmult *= 1.5
			textprofcost *= 6
			texturerectlist.set_item_text(2,"Payout increase "+str(textprofcost)+" minutes")
	texturerectlist.deselect_all()


func _on_textrecttimer_timeout() -> void:
	for i in get_tree().get_nodes_in_group("textrects"):
		value += incval * universal_bonus * textmult * textu_bonus
		var instance = MONEYNUMBER.instantiate()
		numbers.add_child(instance)
		if instance.global_position == Vector2(0,0):
			if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
				pass
			else:
				instance.text = "+"+str(snapped(incval*textmult*universal_bonus*textu_bonus,0.1))
				instance.global_position = Vector2(i.global_position.x,i.global_position.y)


func _on_mute_pressed() -> void:
	if audio_stream_player_2d.stream_paused == true:
		audio_stream_player_2d.stream_paused = false
	else:
		audio_stream_player_2d.stream_paused = true


func _on_color_rect_item_selected(index: int) -> void:
	if index == 0:
		if value >= newcolorrectcost:
			value -= newcolorrectcost
			newcolorrectcost *= 6
			var instance = COLORRECT.instantiate()
			mainlayer.add_child(instance)
			instance.global_position = Vector2((colorrects*50),300)
			colorrects += 1
			instance.add_to_group("colorects")
			colorrectlist.set_item_text(0,"New ColorRect "+str(newcolorrectcost)+" minutes")
			colorrectlist.deselect_all()
		else:
				colorrectlist.deselect_all()
	if index == 1:
		if value >= deccolortimecost:
			value -= deccolortimecost
			colorrecttimer.wait_time *= 0.85
			deccolortimecost *= 6
			colorrectlist.set_item_text(1,"Faster colors "+str(deccolortimecost)+" minutes")
	if index == 2:
		if value >= colorprofcost:
			value -= colorprofcost
			colormult *= 1.8
			colorprofcost *= 6
			colorrectlist.set_item_text(2,"Increase ColorRect Profit "+str(colorprofcost)+" minutes")
	colorrectlist.deselect_all()


func _on_color_rect_timer_timeout() -> void:
	var mult
	for i in get_tree().get_nodes_in_group("colorects"):
		i.color = Color(randf(),randf(),randf(),randf_range(1,colou))
		var tempmult = (1 - i.color.a) * 10
		value += incval * universal_bonus * colormult * colo_bonus * tempmult
		var instance = MONEYNUMBER.instantiate()
		numbers.add_child(instance)
		if instance.global_position == Vector2(0,0):
			if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
				pass
			else:
				instance.text = "+"+str(snapped(incval*colormult*colo_bonus*universal_bonus*tempmult,0.1))
				instance.global_position = Vector2(i.global_position.x,i.global_position.y)


func _on_area_2d_item_selected(index: int) -> void:
	if index == 0:
		if value >= area2dcost:
			if hasarea2d == false:
				value -= area2dcost
				hasarea2d = true
				area2d.show()
				area_2d.set_item_text(0,"Area2D Purchased")
				area_2d.deselect_all()
			else:
				area_2d.deselect_all()
	if index == 1:
		if value >= enlargearea2dcost:
			value -= enlargearea2dcost
			area2d.scale *= Vector2(1.2,1.2)
			enlargearea2dcost *= 1.4
			area_2d.set_item_text(1,"Enlarge Area2D "+str(enlargearea2dcost)+" minutes")
	if index == 2:
		if value >= areaprofcost:
			value -= areaprofcost
			areamult *= 3
			areaprofcost *= 6
			area_2d.set_item_text(2,"Increase Area2D profit "+str(areaprofcost)+" minutes")
	area_2d.deselect_all()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("rigidbody"):
		value += incval * universal_bonus * areamult * area_bonus
		var instance = MONEYNUMBER.instantiate()
		numbers.add_child(instance)
		if instance.global_position == Vector2(0,0):
			if get_tree().get_node_count_in_group("floatnumbs") > MAXNUMBS:
				pass
			else:
				instance.text = "+"+str(snapped(incval*areamult*area_bonus*universal_bonus,0.1))
				instance.global_position = body.global_position

func _on_prestigebutton_pressed() -> void:
	confirm.show()

func _on_no_pressed() -> void:
	confirm.hide()

func _on_yes_pressed() -> void:
	confirm.hide()
	for i in get_tree().get_nodes_in_group("char2dbody"):
		i.queue_free()
	for i in get_tree().get_nodes_in_group("rigidbody"):
		i.queue_free()
	for i in get_tree().get_nodes_in_group("floatnumbs"):
		i.queue_free()
	for i in get_tree().get_nodes_in_group("textrects"):
		i.queue_free()
	for i in get_tree().get_nodes_in_group("colorects"):
		i.queue_free()
	node_2d.hide()
	area_2d.hide()
	for i in [1,2,3,4,5]:
		tab_container.set_tab_hidden(i,true)
	value = 0
	incval = 1
	boughtups = 0
	cost = 5
	percycle = 1
	cyclelength = 10
	newcharbodycost = 1000
	char2ds = 0
	decchartimecost = 10000
	mult2dcharcost = 5000
	char2dmult = 1
	changetime = 15
	newrigidbodycost = 25000
	rigidbodies = 0
	decrigtimecost = 40000
	profrigcost = 50000
	profrigmult = 5
	newtextrectcost = 100000
	textrects = 0
	dectexttimecost = 150000
	textprofcost = 150000
	textmult = 10
	newcolorrectcost = 3000000
	colorrects = 0
	deccolortimecost = 10000000
	colorprofcost = 30000000
	colormult = 40
	area2dcost = 500000000
	enlargearea2dcost = 1000000000
	areaprofcost = 800000000
	areamult = 100
	inshop = []
	inshoptype = []
	hasshop = false
	hasnode2D = false
	node2disinshop = false
	unlockedchar2d = false
	unlockedrigbod2d = false
	unlockedtextrect = false
	maxrects = false
	unlockedcolorrect = false
	hasarea2d = false
	unlockedarea2d = false
	prestige += prestigeamount*prest_bonus
	prestigeamount = 0
	item_list.clear()
	addrandshopitem()
	colorrecttimer.wait_time = 8 * colot_bonus
	textrecttimer.wait_time = 8 * textut_bonus
	rigidbodytimer.wait_time = 10 * rigidtime_bonus
	node_2_dtime.wait_time = 10
	get_tree().call_group("char2dbody","set","time",15)

func _on_treeroot_upgraded(what: Variant, magnitude: Variant, prestigecost: Variant) -> void:
	prestige -= prestigecost
	match what:
		"control":
			control_bonus *= magnitude
		"control":
			control_bonus *= magnitude
		"rigid":
			rigid_bonus *= magnitude
		"time":
			Engine.time_scale *= magnitude
		"area":
			area_bonus *= magnitude
		"textu":
			textu_bonus += magnitude
		"colo":
			colo_bonus += magnitude
		"char2":
			char2d_bonus *= magnitude
		"char2t":
			char2dtime_bonus *= magnitude
		"rigidt":
			rigidtime_bonus *= magnitude
			rigidbodytimer.wait_time *= rigidtime_bonus
		"prest":
			prest_bonus *= magnitude
		"prestm":
			prestm_bonus *= magnitude
		"colot":
			colot_bonus *= magnitude
			colorrecttimer.wait_time *= magnitude
		"colou":
			colou *= magnitude
		"areash":
			changeshape.emit()
		"textut":
			textut_bonus *= magnitude
			textrecttimer.wait_time *= magnitude

func _on_button_pressed() -> void:
	mainlayer.hide()
	shop.hide()
	foreground.hide()
	background.hide()
	treeroot.show()


func _on_closeprest_pressed() -> void:
	mainlayer.show()
	shop.show()
	foreground.show()
	background.show()
	treeroot.hide()



func _on_button_2_pressed() -> void:
	value = 5000000000000000
