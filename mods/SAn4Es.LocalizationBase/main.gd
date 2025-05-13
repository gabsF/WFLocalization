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

var shops = []
var other = []
var dialog = []

var baseDir = OS.get_executable_path().get_base_dir() + "/GDWeave/Mods/SAn4Es.LocalizationBase/"
var lang = "en"
var languages = ["en"]


var fonts = []
var font = DynamicFont.new()
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
	
	PlayerData.connect("_inventory_refresh", self, "_shop_refresh")
	SceneTransition.connect("_finished", self, "_On_Test")
	OptionsMenu.connect("_options_update", self, "_Options_Update")
	if lang != "en":
		print(OS.get_executable_path().get_base_dir() + "/strings.csv")
		writeToArr(buttons, baseDir + lang + "/buttons.csv")
		writeToArr(npc, baseDir + lang + "/npc.csv")
		writeToArr(tips, baseDir + lang + "/tooltips.csv")
		writeToArr(quests, baseDir + lang + "/quests.csv")
		#writeToArr(quality, baseDir + lang + "/Quality.csv")
		#writeToArr(lure, baseDir + lang + "/Lure.csv")
		#writeToArr(bait, baseDir + lang + "/Bait.csv")
		writeToArr(shops, baseDir + lang + "/shop.csv")
		writeToArr(other, baseDir + lang + "/other.csv")
		writeToArr(dialog, baseDir + lang + "/dialog.csv")
		
		fonts.append(baseDir + lang + "/fonts/base.ttf")
		fonts.append(baseDir + lang + "/fonts/alt.ttf")
		
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

func writeToArr(arr, path):
	var file = File.new()
	file.open(path, file.READ)
	while !file.eof_reached():
		var csv = file.get_csv_line()
	#	print(csv)
		arr.append(csv)
	file.close()

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
func _Options_Update():
	if lang != "en":
		match PlayerData.player_options.altfont:
			0: font.font_data = load(fonts[0])
			1: font.font_data = load(fonts[1])
		
		font.size = 28
		match PlayerData.player_options.altfont:
			0: load("res://Assets/Themes/main.tres").default_font.font_data = load(fonts[0])
			1: load("res://Assets/Themes/main.tres").default_font.font_data = load(fonts[1])

func menu_entered(e):
	if e == 6:
		translateDiag()

func _On_Test():
	yield(get_tree().create_timer(0.3), "timeout")
	
	PlayerData.connect("_item_equip", self, "_item_equip")
	createOpt()
	if lang != "en":
		
		var hud = get_node_or_null("/root/playerhud")
		if hud != null:
			hud.connect("_menu_entered", self, "menu_entered")
		
		translateCosmetic()
		translateItems()
		translateButtons()
		translateNPC()
		translateTips()
		translateQests()
	#var node__ = get_node_or_null("/root/playerhud/esc_menu/VBoxContainer")
	#if node__ != null:
	#	for _i in node__.get_children():
	#		print(_i)
func _shop_refresh():
	
	var shopNode = get_node_or_null("/root/playerhud/main/shop/Panel2/MarginContainer2/ScrollContainer/HBoxContainer/VBoxContainer")
	if shopNode != null:
		for i in shopNode.get_children():
			if i is Label:
				for s in other:
					if s[0] != "":
						i.text = i.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
						if lang == "test":
							i.text = "test"
			
			if i is GridContainer:
				#var file = File.new()
				#if file.open(baseDir + "/" + i.name + ".txt", File.WRITE) != 0:
				#	print("Error opening file")
				#	return
				var text = []
				var buttons = i.get_children()
				for j in buttons:
					if j is Button:
						for s in shops:
							if s[0] != "":
								j.get_child(0).header = j.get_child(0).header.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
								j.get_child(0).body = j.get_child(0).body.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
							if lang == "test":
								j.get_child(0).header = "test"
								j.get_child(0).body = "test"
	
	var sellAllNode = get_node_or_null("/root/playerhud/main/shop/Panel2/MarginContainer2/ScrollContainer/HBoxContainer/VBoxContainer/sell_all_container")
	if sellAllNode != null:
		for s in other:
			if s[0] != "":
				sellAllNode.get_child(0).text = sellAllNode.get_child(0).text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				sellAllNode.get_child(1).get_child(0).text = sellAllNode.get_child(1).get_child(0).text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					sellAllNode.get_child(0).text = "test"
					sellAllNode.get_child(1).get_child(0).text = "test"
		
		
	yield(get_tree().create_timer(0.05), "timeout")
	var jouButtons = get_node_or_null("/root/playerhud/main/menu/tabs/journal/journal_buttons")
	for i in jouButtons.get_children():
		i.connect("pressed", self, "_journal_update")
		for s in other:
			if s[0] != "":
				i.text = i.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					i.text = "test"
	
	var butt = get_node_or_null("/root/playerhud/main/menu/buttons")
	if butt != null:
		for i in butt.get_children():
			i.connect("_pressed", self, "translateTitle")
	translateTitle(1)
	_tab_changed()
	_pitch_change(1)
	var vos = get_node_or_null("/root/playerhud/main/menu/tabs/outfit/Panel4/tabs/misc/HBoxContainer/vbox/voice_options/HBoxContainer/HSlider")
	var vos1 = get_node_or_null("/root/playerhud/main/menu/tabs/outfit/Panel4/tabs/misc/HBoxContainer/vbox/voice_options/HBoxContainer2/speed")
	if vos != null:
		vos.connect("value_changed", self, "_pitch_change")
		vos1.connect("value_changed", self, "_pitch_change")
	
	
	var tab_tool = get_node_or_null("/root/playerhud/main/menu/tabs/inventory/tabs/tab_tool")
	var tab_creatures = get_node_or_null("/root/playerhud/main/menu/tabs/inventory/tabs/tab_creatures")
	if tab_tool != null:
		tab_tool.connect("pressed", self, "_tab_changed")
		tab_creatures.connect("pressed", self, "_tab_changed")

func translateDiag():
	var n = get_node_or_null("/root/playerhud/main/dialogue/Panel/Panel2/bplabel")
	if n != null:
		for s in dialog:
			if s[0] != "":
				n.text = n.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					n.text = "test"
	
	var hud = get_node_or_null("/root/playerhud")
	var s_ = ""
	for i in hud.dialogue_text:
		s_ += String(i)
	if hud != null:
		for s in dialog:
			if s[0] != "":
				s_ = s_.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
		if s_ != "":
			hud.dialogue._open(s_.split(""))
		#yield(get_tree().create_timer(0.01), "timeout")
		#hud.dialogue_text = s_.split("")
		#print(hud.dialogue_text)

func translateTitle(v):
	yield(get_tree().create_timer(0.01), "timeout")
	var title = get_node_or_null("/root/playerhud/main/menu/Panel2/bplabel")
	if title != null:
		for s in other:
			if s[0] != "":
				title.text = title.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					title.text = "test"
				
	title = get_node_or_null("/root/playerhud/main/shop/Panel4/bplabel")
	if title != null:
		for s in other:
			if s[0] != "":
				title.text = title.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					title.text = "test"
	

func _pitch_change(v):
	yield(get_tree().create_timer(0.01), "timeout")
	var vo = get_node_or_null("/root/playerhud/main/menu/tabs/outfit/Panel4/tabs/misc/HBoxContainer/vbox/voice_options/HBoxContainer/Label")
	var vo1 = get_node_or_null("/root/playerhud/main/menu/tabs/outfit/Panel4/tabs/misc/HBoxContainer/vbox/voice_options/HBoxContainer2/speedlbl")
	if vo != null:
		for s in other:
			if s[0] != "":
				vo.text = vo.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				vo1.text = vo1.text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					vo.text = "test"
					vo1.text = "test"
func _tab_changed():
	yield(get_tree().create_timer(0.05), "timeout")
	
	_journal_update()
	
	_item_equip()
	var inv = get_node_or_null("/root/playerhud/main/menu/tabs/inventory/Panel/items/")
	if inv != null:
		for i in inv.get_children():
			var item = i.get_child(0).get_node_or_null("tooltip_node")
			for s in other:
				if s[0] != "":
					item.header = item.header.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					item.body = item.body.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					
	var jou = get_node_or_null("/root/playerhud/main/menu/tabs/journal/Panel/MarginContainer/HScrollBar/GridContainer")
	if jou != null:
		for i in jou.get_children():
			var item = i.get_node_or_null("tooltip_node")
			for s in other:
				if s[0] != "":
					item.header = item.header.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					item.body = item.body.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					if lang == "test":
						item.header = "test"
						item.body = "test"
					
func _journal_update():
	yield(get_tree().create_timer(0.05), "timeout")
	var journ = get_node_or_null("/root/playerhud/main/menu/tabs/journal/Panel/MarginContainer/HScrollBar/GridContainer")
	for i in journ.get_children():
		i.connect("mouse_entered", self, "_item_entered")
	
	var n = get_node_or_null("/root/playerhud/main/menu/tabs/journal/prog/TooltipNode")
	if n != null:
		for s in other:
			if s[0] != "":
				n.header = n.header.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				n.body = n.body.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					n.header = "test"
					n.body = "test"

func _item_entered():
	yield(get_tree().create_timer(0.01), "timeout")
	var label = get_node_or_null("/root/playerhud/main/menu/tabs/journal/Panel3/body")
	var labelh = get_node_or_null("/root/playerhud/main/menu/tabs/journal/Panel3/header")
	if label != null:
		print(labelh.text)
		for s in other:
			if s[0] != "":
				label.bbcode_text = label.bbcode_text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				labelh.bbcode_text = labelh.bbcode_text.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
				if lang == "test":
					label.bbcode_text = "test"
					labelh.bbcode_text = "test"
				
func _item_equip():
	var inv = get_node_or_null("/root/playerhud/main/in_game/hotbar/")
	if inv != null:
		for i in inv.get_children():
			var item = i.get_child(0).get_node_or_null("tooltip_node")
			for s in other:
				if s[0] != "":
					item.header = item.header.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					item.body = item.body.replace(s[0].replace("\\n", "\n"), s[1].replace("\\n", "\n"))
					if lang == "test":
						item.header = "test"
						item.body = "test"
			
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
				if lang == "test":
					node_.text = "test"
func translateTips():
	
	
	for i in tips.size():
		if i != tips.size()-1:
			var node_ = get_node_or_null(tips[i][0])
			if node_ != null:
				node_.header = tips[i][1]
				if lang == "test":
					node_.header = "test"
				if "body" in node_:
					node_.body = tips[i][2].replace("\\n", "\n")
					if lang == "test":
						node_.body = "test"
				if "desc" in node_:
					node_.desc = tips[i][2].replace("\\n", "\n")
					if lang == "test":
						node_.desc = "test"

func translateCosmetic():
	for i in cosmetic:
		if i[0] != "":
		#if Globals.cosmetic_data[i[0]]["file"].name != null:
			Globals.cosmetic_data[i[0]]["file"].name = i[1]
			Globals.cosmetic_data[i[0]]["file"].desc = i[2]
			Globals.cosmetic_data[i[0]]["file"].title = i[3]
			if lang == "test":
				Globals.cosmetic_data[i[0]]["file"].name = "test"
				Globals.cosmetic_data[i[0]]["file"].desc = "test"
			
func translateQests():
		
	for i in quests:
		if i[0] != "":
			for j in PlayerData.current_quests.keys():
				if i[0] == PlayerData.current_quests[j].action or i[0] == PlayerData.current_quests[j].goal_id:
					PlayerData.current_quests[j].title = i[1]
					if lang == "test":
						PlayerData.current_quests[j].title = "test"
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
			Globals.item_data[i[0]]["file"].test = i[5]
			if lang == "test":
				Globals.item_data[i[0]]["file"].item_name = "test"
				Globals.item_data[i[0]]["file"].item_description = "test"
				Globals.item_data[i[0]]["file"].help_text = "test"
				Globals.item_data[i[0]]["file"].catch_blurb = "test"
			
	#for i in Globals.item_data.keys():
		#Globals.item_data[i]["file"].item_name
		#print(i)
		#print(Globals.item_data[i]["file"].item_name)

func translateButtons():
	

	
	var node = get_node_or_null("/root/main_menu/VBoxContainer")
	if node != null:
		for _i in node.get_children():
			_i.set("custom_fonts/font", font)
	var node1 = get_node_or_null("/root/playerhud/esc_menu/VBoxContainer")
	if node1 != null:
		for _i in node1.get_children():
			_i.set("custom_fonts/font", font)	
			
	for i in buttons.size():
		if buttons[i][0] != "":
			var node_ = get_node_or_null(buttons[i][0])
			if node_ != null:
				node_.text = buttons[i][1].replace("\\n", "\n")
				if lang == "test":
					node_.text = "test"
				
	
				
