extends Node2D


var hovering = false
signal turn_changed
var picked_already = false

func _on_Area_mouse_entered():
	hovering = true


func _on_Area_mouse_exited():
	hovering = false


func _ready():
	#connect("")
	pass


func _process(delta):
	if hovering:
		if !picked_already:
			$PickButton.visible = true
		$AttackButton.visible = true
	elif !hovering:
		$AttackButton.visible = false
		$PickButton.visible = false


func _on_AttackButton_pressed():
	if Deck.player_turn == true:
		Deck.player_health += 3
		get_parent().get_parent().get_parent().get_node("Camera2D").get_node("ScreenShake").play("Shake")
		$AnimationPlayer.play("Discard")
		$DiscardSound.play()
		Deck.global_current_hand.remove(len(Deck.global_current_hand) - 1)
		Deck.player_turn = false
		connect("turn_changed", Deck.current_boss, "on_turn_change")
		emit_signal("turn_changed")
		#queue_free()


func _on_AttackButton_mouse_entered():
	hovering = true


func _on_AttackButton_mouse_exited():
	hovering = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Discard":
		queue_free()


func _on_PickButton_pressed():
	$DiscardSound.play()
	randomize()
	var chance: int = rand_range(0, 10)
	if chance == 1 or chance == 3 or chance == 5:
		self.name = "CardD"
		var new_card = Deck.AXE_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 0 or chance == 6:
		self.name = "CardD"
		var new_card = Deck.TOXIC_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 2 or chance == 7:
		self.name = "CardD"
		var new_card = Deck.KNIGHT_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 4 or chance == 8:
		self.name = "CardD"
		var new_card = Deck.FAIRY_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 9:
		self.name = "CardD"
		var new_card = Deck.DRAW_DRAW_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()


func _on_PickButton_mouse_entered():
	hovering = true


func _on_PickButton_mouse_exited():
	hovering = false
