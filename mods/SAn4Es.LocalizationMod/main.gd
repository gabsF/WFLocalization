extends Node

onready var p_node = get_parent()
var buttons = []
var npc = []
var tips = []
var cosmetic = []
var items = []
var quests = []

var quality = []
var bait = []
var lure = []

func _ready():
	SceneTransition.connect("_finished", self, "_On_Test")
	
	print(OS.get_executable_path().get_base_dir() + "/strings.csv")
	var file = File.new()
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/buttons.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		buttons.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/npc.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		npc.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/tooltips.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		tips.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/quests.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		quests.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Quality.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		quality.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Lure.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		lure.append(csv)
	file.close()
	
	file.open("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Bait.csv", file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		bait.append(csv)
	file.close()
	
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Accessory.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Bobbers.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Eyes.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Hats.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Legs_Pants.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Mouths.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Noses.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Overshirts.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Patterns.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_PrimaryColors.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_RankTitles.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_SecondaryColors.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Tails.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Titles.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetic_Undershirts.csv")
	readCosmetic("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Cosmetics.csv")
		
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_Alien.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_Deep.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_Freshwater.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_Ocean.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_RainSpecial.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_Fish_Void.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_MetalDetectLoot.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_RodLuck.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Creatures_WaterTrash.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Item_Chalk.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Item_Consumables.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Item_Tools.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Items.csv")
	readItems("C:/Users/Милк-Тян/Downloads/win64-g352-s158-gs321/ru/Prop_Items.csv")

func readCosmetic(s):
	var file = File.new()
	file.open(s, file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		cosmetic.append(csv)
	file.close()
func readItems(s):
	var file = File.new()
	file.open(s, file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		items.append(csv)
	file.close()

func _On_Test():
	yield(get_tree().create_timer(0.3), "timeout")
	translateCosmetic()
	translateItems()
	translateButtons()
	translateNPC()
	translateTips()
	translateQests()
	translateOther()
	#var node__ = get_node_or_null("/root/playerhud/esc_menu/VBoxContainer")
	#if node__ != null:
	#	for _i in node__.get_children():
	#		print(_i)
	
const BAIT_DATA = {
	"": {"icon": preload("res://Assets/Textures/UI/bait_icons1.png"), "name": "No Bait", "desc": "No chance of catching anything with this!", "cost": 0}, 
	"worms": {"icon": preload("res://Assets/Textures/UI/bait_icons2.png"), "name": "Черви", "desc": "Low Quality Cheap Bait\nCatches Low Tier fish only", "cost": 0}, 
	"cricket": {"icon": preload("res://Assets/Textures/UI/bait_icons3.png"), "name": "Crickets", "desc": "Standard Quality Cheap Bait\nCatches all Tiers of fish\nLow chance of finding SHINING fish", "cost": 20}, 
	"leech": {"icon": preload("res://Assets/Textures/UI/bait_icons4.png"), "name": "Leeches", "desc": "Above Standard Quality Bait\nCatches all Tiers of fish\nLow chance of finding GLISTENING fish", "cost": 50}, 
	"minnow": {"icon": preload("res://Assets/Textures/UI/bait_icons5.png"), "name": "Minnows", "desc": "High Quality Bait\nCatches all Tiers of fish\nLow chance of finding OPULENT fish", "cost": 100}, 
	"squid": {"icon": preload("res://Assets/Textures/UI/bait_icons6.png"), "name": "Squid", "desc": "Very High Quality Bait\nCatches all Tiers of fish\nLow chance of finding RADIANT fish", "cost": 200}, 
	"nautilus": {"icon": preload("res://Assets/Textures/UI/bait_icons7.png"), "name": "Nautiluses", "desc": "Pristine Quality Bait\nCatches all Tiers of fish\nLow chance of finding ALPHA fish", "cost": 500}, 
}

func translateOther():
	print(typeof(PlayerData.BAIT_DATA["worms"].name))
	print(typeof(bait[1][0]))
	#PlayerData.bai["worms"] = BAIT_DATA["worms"]
	#PlayerData.BAIT_DATA[0].name = "dsadsa"
	
	#for i in PlayerData.BAIT_DATA.keys():
	#	print(PlayerData.BAIT_DATA[i])
	#for i in bait:
	#	if i[0] != "":
	#		print(PlayerData.BAIT_DATA[i[0]])
	#		PlayerData.BAIT_DATA[i[0]]["name"] = i[1]
	#		print(PlayerData.BAIT_DATA[i[0]].name)
			
	#for i in quality:
	#	if i[0] != "":
	#		PlayerData.QUALITY_DATA[i[0]].name = i[1]
	#		PlayerData.QUALITY_DATA[i[0]].title = i[2]
			
func translateNPC():
	var node__ = get_node_or_null("/root/world/Viewport/main/map/main_map/zones/")
	if node__ != null:
		for _i in node__.get_children():
			print(_i)
			
	for i in npc.size():
		if i != npc.size()-1:
			var node_ = get_node_or_null(npc[i][0])
			if node_ != null:
				node_.text = npc[i][1]
				
func translateTips():
	for i in tips.size():
		if i != tips.size()-1:
			var node_ = get_node_or_null(tips[i][0])
			if node_ != null:
				node_.header = tips[i][1]
				if "body" in node_:
					node_.body = tips[i][2]
				if "desc" in node_:
					node_.desc = tips[i][2]

func translateCosmetic():
	for i in cosmetic:
		if i[0] != "":
		#if Globals.cosmetic_data[i[0]]["file"].name != null:
			Globals.cosmetic_data[i[0]]["file"].name = i[1]
			Globals.cosmetic_data[i[0]]["file"].desc = i[2]
			
func translateQests():
	for i in quests:
		if i[0] != "":
			for j in PlayerData.current_quests.keys():
				if i[0] == PlayerData.current_quests[j].action or i[0] == PlayerData.current_quests[j].goal_id:
					PlayerData.current_quests[j].title = i[1]
	#for i in PlayerData.current_quests.keys():
		#print(PlayerData.current_quests[i].title)
				
func translateItems():
	for i in items:
		if i[0] != "":
		#if Globals.cosmetic_data[i[0]]["file"].name != null:
			Globals.item_data[i[0]]["file"].item_name = i[1]
			Globals.item_data[i[0]]["file"].item_description = i[2]
			Globals.item_data[i[0]]["file"].help_text = i[3]
			Globals.item_data[i[0]]["file"].catch_blurb = i[4]
		
	#for i in Globals.item_data.keys():
		#Globals.item_data[i]["file"].item_name
		#print(i)
		#print(Globals.item_data[i]["file"].item_name)

func translateButtons():
	var font = DynamicFont.new()
	font.font_data = load("res://Assets/Themes/unifont-16.0.01.otf")
	font.size = 24
	
	
	var node = get_node_or_null("/root/main_menu/VBoxContainer")
	if node != null:
		for _i in node.get_children():
			_i.set("custom_fonts/font", font)
	var node1 = get_node_or_null("/root/playerhud/esc_menu/VBoxContainer")
	if node1 != null:
		for _i in node1.get_children():
			_i.set("custom_fonts/font", font)
	
	for i in buttons.size():
		if i != buttons.size()-1:
			var node_ = get_node_or_null(buttons[i][0])
			if node_ != null:
				node_.text = buttons[i][1]
