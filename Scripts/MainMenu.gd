extends Control

var butt_pressed = 0
var pr_res = preload("res://Resources/SaveData.tres")

func _ready():
	var save_res = ResourceLoader.load("user://SaveData.tres")
	if save_res == null or !save_res:
		var f = File.new()
		f.open("user://SaveData.tres", File.WRITE)
		f.store_string(" ")
		f.close()
		ResourceSaver.save("user://SaveData.tres", pr_res)
		save_res = ResourceLoader.load("user://SaveData.tres")
	yield(get_tree(), "idle_frame")
	$Timer.start()
	$HighScore.text = "Personal high score: " + str(save_res.high_score)


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.playback_speed = 0.6
	$AnimationPlayer.play("Bob")


func _on_PlayButton_pressed():
	butt_pressed = 1
	$Blip.play()
	$Overlay/Anim.play("FadeOut")


func _on_Anim_animation_finished(anim_name):
	if butt_pressed == 1:
		get_tree().change_scene("res://Scenes/Game.tscn")
	elif butt_pressed == 2:
		get_tree().change_scene("res://Scenes/H2P.tscn")
		


func _on_Button2_pressed():
	butt_pressed = 2
	$Blip.play()
	$Overlay/Anim.play("FadeOut")


func _on_Timer_timeout():
	pass # Replace with function body.
