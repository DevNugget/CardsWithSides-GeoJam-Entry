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
		if !"Ocean" in Deck.current_boss.get_node("Name").text:
			get_parent().get_parent().get_parent().get_node("BossPos").get_node("Boss").health -= 1
			$Blood.play()
			$CanvasLayer/BloodParticles.emitting = true
			get_parent().get_parent().get_parent().get_node("Camera2D").get_node("ScreenShake").play("Shake")
		$AnimationPlayer.play("Discard")
		$DiscardSound.play()
		Deck.global_current_hand.remove(len(Deck.global_current_hand) - 1)
		#Deck.player_turn = false
		#connect("turn_changed", Deck.current_boss, "on_turn_change")
		#emit_signal("turn_changed")
		#queue_free()


func _on_AttackButton_mouse_entered():
	hovering = true


func _on_AttackButton_mouse_exited():
	hovering = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Discard":
		queue_free()


func _on_PickButton_pressed():
	randomize()
	var chance: int = rand_range(0, 3)
	if chance == 1 or chance == 3:
		self.name = "CardD"
		var new_card = Deck.HP_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 0:
		self.name = "CardD"
		var new_card = Deck.AXE_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 2:
		self.name = "CardD"
		var new_card = Deck.KNIGHT_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()
	elif chance == 4:
		self.name = "CardD"
		var new_card = Deck.FAIRY_CARD.instance()
		new_card.get_node("DiscardSound").play()
		get_parent().add_child(new_card)
		new_card.picked_already = true
		queue_free()


func _on_PickButton_mouse_entered():
	hovering = true


func _on_PickButton_mouse_exited():
	hovering = false
