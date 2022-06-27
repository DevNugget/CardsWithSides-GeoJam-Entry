extends TextureRect

export var turns_alive = 0

func animate():
	$AnimationPlayer.play("Animate")
