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

var baseDir = OS.get_executable_path().get_base_dir() + "/GDWeave/Mods/SAn4Es.LocalizationBase/"
var lang = "en"
var languages = ["en"]
func _ready():
	var dir = Directory.new()
	if dir.open(baseDir) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				if file_name != "." and file_name != "..":
					languages.append(file_name)
			file_name = dir.get_next()
	
	var sav = File.new()
	
	# Open existing file
	if sav.open(baseDir + "/opt.txt", File.READ) != 0:
		print("Error opening file")
	lang = sav.get_line()
	
	SceneTransition.connect("_finished", self, "_On_Test")
	if lang != "en":
		print(OS.get_executable_path().get_base_dir() + "/strings.csv")
		var file = File.new()
		file.open(baseDir + lang + "/buttons.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			buttons.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/npc.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			npc.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/tooltips.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			tips.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/quests.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			quests.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/Quality.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			quality.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/Lure.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			lure.append(csv)
		file.close()
		
		file.open(baseDir + lang + "/Bait.csv", file.READ)
		while !file.eof_reached():
			var csv = file.get_csv_line()
		#	print(csv)
			bait.append(csv)
		file.close()
		
		readCosmetic(baseDir + lang + "/Cosmetic_Accessory.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Bobbers.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Eyes.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Hats.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Legs_Pants.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Mouths.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Noses.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Overshirts.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Patterns.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_PrimaryColors.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_RankTitles.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_SecondaryColors.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Tails.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Titles.csv")
		readCosmetic(baseDir + lang + "/Cosmetic_Undershirts.csv")
		readCosmetic(baseDir + lang + "/Cosmetics.csv")
			
		readItems(baseDir + lang + "/Creatures_Fish_Alien.csv")
		readItems(baseDir + lang + "/Creatures_Fish_Deep.csv")
		readItems(baseDir + lang + "/Creatures_Fish_Freshwater.csv")
		readItems(baseDir + lang + "/Creatures_Fish_Ocean.csv")
		readItems(baseDir + lang + "/Creatures_Fish_RainSpecial.csv")
		readItems(baseDir + lang + "/Creatures_Fish_Void.csv")
		readItems(baseDir + lang + "/Creatures_MetalDetectLoot.csv")
		readItems(baseDir + lang + "/Creatures_RodLuck.csv")
		readItems(baseDir + lang + "/Creatures_WaterTrash.csv")
		readItems(baseDir + lang + "/Item_Chalk.csv")
		readItems(baseDir + lang + "/Item_Consumables.csv")
		readItems(baseDir + lang + "/Item_Tools.csv")
		readItems(baseDir + lang + "/Items.csv")
		readItems(baseDir + lang + "/Prop_Items.csv")

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

func createOpt():
	var chooseLang = OptionButton.new()
	chooseLang.text = "Language"
	chooseLang.rect_size = Vector2(150,34)
	chooseLang.anchor_bottom = 0.016
	chooseLang.anchor_top = 0.016
	chooseLang.anchor_left = 0.016
	chooseLang.anchor_right = 0.016
	chooseLang.name = "setLang"
	for i in languages:
		chooseLang.add_item(i)
	chooseLang.select(languages.find(lang, 0))
	
	var button = Button.new()
	button.text = "Save"
	button.rect_size = Vector2(150,34)
	button.anchor_bottom = 0.016
	button.anchor_top = 0.016
	button.anchor_left = 0.1
	button.anchor_right = 0.1
	
	button.connect("pressed", self, "_button_pressed")
	var menuNode = get_node_or_null("/root/main_menu")
	if menuNode != null:
		print("NOD")
		menuNode.add_child(chooseLang)
		menuNode.add_child(button)
	
func _button_pressed():
	print(languages[get_node_or_null("/root/main_menu/setLang").selected])
	lang = languages[get_node_or_null("/root/main_menu/setLang").selected]
	
	var file = File.new()
	if file.open(baseDir + "/opt.txt", File.WRITE) != 0:
		print("Error opening file")
		return

	# Save the dictionary as JSON (or whatever you want, JSON is convenient here because it's built-in)
	file.store_line(lang)
	file.close()
	
	
func _On_Test():
	yield(get_tree().create_timer(0.3), "timeout")
	
	createOpt()
	
	translateCosmetic()
	translateItems()
	translateButtons()
	translateNPC()
	translateTips()
	translateQests()
#	translateOther()
	#var node__ = get_node_or_null("/root/playerhud/esc_menu/VBoxContainer")
	#if node__ != null:
	#	for _i in node__.get_children():
	#		print(_i)

#func translateOther():
	
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
