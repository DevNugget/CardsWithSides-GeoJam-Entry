extends Control





func _on_Button_pressed():
	$Blip.play()


func _on_Blip_finished():
	get_tree().change_scene("res://Scenes/H2P2.tscn")
