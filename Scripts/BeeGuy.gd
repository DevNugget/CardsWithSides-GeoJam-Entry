extends Node2D


export var health: int = 14
signal on_die


func _ready():
	return
	pass
	connect("turn_changed", self, "on_turn_changed")
	connect("turn_changed", get_parent().get_node("Hand/CardTwoPos/Card"), "on_turn_changed")
	connect("turn_changed", get_parent().get_node("Hand/CardThreePos/Card"), "on_turn_changed")


func _process(delta):
	$RichTextLabel.text = "HP: " + str(health)
	if health < 1:
		die()


func die():
	$AnimationPlayer.play("Die")
	#get_parent().get_parent().get_node("Camera2D").get_node("ScreenShake").play("Die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Die":
		connect("on_die", get_parent().get_parent(), "on_boss_die")
		emit_signal("on_die")
		Deck.score += 14
		#Deck.add_new_cards()
		queue_free()
	elif anim_name == "Attack":
		Deck.player_health -= 2
		Deck.player_turn = true
		$AnimationPlayer.play("Idle")

func on_turn_change():
	$AnimationPlayer.play("Attack")
