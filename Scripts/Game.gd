extends Node2D

const SNAKE_BOSS = preload("res://Scenes/SnakeBoss.tscn")
const RAT_BOSS = preload("res://Scenes/RatBoss.tscn")
const RAT_MIN = preload("res://Scenes/RatMinion.tscn")
const MINIMA_CUBE = preload("res://Scenes/MinimaCube.tscn")
const BEE_GUY = preload("res://Scenes/BeeGuy.tscn")
const OCEAN_GUY = preload("res://Scenes/OceanDude.tscn")

#var current_hand_global = []
var current_boss
var can_draw = true
signal on_redraw_requested

var save_resource = ResourceLoader.load("user://SaveData.tres")

func _ready():
	Deck.score = 0
	Deck.player_health = 12
	Deck.global_current_hand = []
	Deck.deck = []
	randomize()
	Deck.generate_random_deck()
	Deck.player_turn = true
	generate_boss()
	#connect("on_die", Deck.current_boss, "on_boss_die")


func _process(delta):
	$Score.text = "Score: " + str(Deck.score)
	if Deck.player_health < 1 or len(Deck.deck) < 3:
		$CanvasLayer/Overlay/AnimationPlayer.play("Dead")
		$Blood.play()
		#Engine.time_scale = 0.5
		$DeadCooldown.start()
	if Deck.player_turn:
		$TurnDisplay.text = "Current Turn: YOU"
	else:
		$TurnDisplay.text = "Current Turn: ENEMY"
	if Deck.player_health < 10:
		$HealthDisplay.text = "0" + str(Deck.player_health)
	else:
		$HealthDisplay.text = str(Deck.player_health)
	$DeckSprite/CardCount.text = "x" + str(len(Deck.deck))
	if len(Deck.global_current_hand) > 0:
		can_draw = false
	else:
		can_draw = true

func _on_Draw_pressed():
	if $BlipSound.playing == false:
		$BlipSound.play()
	draw_cards()


func draw_cards():
	#yield(get_tree(), "idle_frame")
	if len(Deck.deck) >= 3 and can_draw:
		var cards_drawn = [Deck.deck[-1]]
		Deck.deck.remove(len(Deck.deck) - 1)
		cards_drawn.append(Deck.deck[-1])
		Deck.deck.remove(len(Deck.deck) - 1)
		cards_drawn.append(Deck.deck[-1])
		Deck.deck.remove(len(Deck.deck) - 1)
		Deck.global_current_hand = cards_drawn
		
		print(cards_drawn)

		for card in range(0, len(cards_drawn)):
			var card_instance
			if cards_drawn[card] == 0 or cards_drawn[card] == 2 or cards_drawn[card] == 3  or cards_drawn[card] == 11:
					card_instance = Deck.AXE_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")
			elif cards_drawn[card] == 1  or cards_drawn[card] == 10:
					card_instance = Deck.HP_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")
					#card_instance.get_node("AnimationPlayer").play("OnEnter")
			elif cards_drawn[card] == 4  or cards_drawn[card] == 9:
					card_instance = Deck.TOXIC_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")
					#card_instance.get_node("AnimationPlayer").play("OnEnter")
			elif cards_drawn[card] == 5 or cards_drawn[card] == 8:
					card_instance = Deck.KNIGHT_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")
			elif cards_drawn[card] == 6 or cards_drawn[card] == 7:
					card_instance = Deck.FAIRY_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")
			elif cards_drawn[card] == 12:
					card_instance = Deck.DRAW_DRAW_CARD.instance()
					if card == 0:
						$Hand/CardOnePos.add_child(card_instance)
					elif card == 1:
						$Hand/CardTwoPos.add_child(card_instance)
					elif card == 2:
						$Hand/CardThreePos.add_child(card_instance)
					#add_child(card_instance)
					#yield(get_tree(), "idle_frame")

func generate_boss():
	var chance:int = rand_range(0, 8)
	
	match chance:
		0: 
			current_boss = SNAKE_BOSS.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
			#connect("on_die", Deck.current_boss, "on_boss_die")
		1:
			current_boss = RAT_BOSS.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		2:
			current_boss = RAT_MIN.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		3:
			current_boss = RAT_MIN.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		4: 
			current_boss = SNAKE_BOSS.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		5:
			current_boss = MINIMA_CUBE.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		6:
			current_boss = BEE_GUY.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)
		7:
			current_boss = OCEAN_GUY.instance()
			current_boss.name = "Boss"
			Deck.current_boss = current_boss
			#current_boss.position = $BossPos.global_position
			$BossPos.add_child(current_boss)

func on_boss_die():
	Deck.player_turn = false
	$DeckSprite/AnimationPlayer.play("CardsFallIn")


func refresh_hand():
	var child = $Hand/CardOnePos.get_child(1)
	if child:
		$Hand/CardOnePos/Card.queue_free()
	child = $Hand/CardTwoPos.get_child(1)
	if child:
		$Hand/CardTwoPos/Card.queue_free()	
	child = $Hand/CardThreePos.get_child(1)
	if child:
		$Hand/CardThreePos/Card.queue_free()	
	#yield(get_tree(), "idle_frame")
	#yield(get_tree(), "node_removed")
	$Timer.start()
	print("S")
	draw_cards()




func _on_AnimationPlayer_animation_finished(anim_name):
	Deck.add_new_cards()
	generate_boss()
	Deck.player_turn = true
	


func _on_Game_on_redraw_requested():
	print("L")
	draw_cards()


func _on_Timer_timeout():
	print("D")
	draw_cards()


func _on_AnimationPlayerPog_animation_finished(anim_name):
	if anim_name == "Dead":
		randomize()
		if Deck.score > save_resource.high_score:
			save_resource.high_score = Deck.score
			ResourceSaver.save("user://SaveData.tres", save_resource)
		Deck.player_health = 12
		Deck.global_current_hand = []
		Deck.deck = []
		Deck.generate_random_deck()
		Deck.player_turn = true
		get_tree().change_scene("res://Scenes/DeathScreen.tscn")


func _on_DeadCooldown_timeout():
	#Deck.player_health = 12
	#Engine.time_scale = 1
	pass
