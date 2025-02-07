extends Node2D

signal theEnd

func _ready() -> void:
	emit_signal("theEnd")
	var anim_player = $Voiture/AnimationPlayer

	# Vérifie si une animation existe avant de la jouer
	if anim_player.has_animation("car_end"):
		anim_player.play("car_end")
	else:
		print("Animation 'car_end' non trouvée dans l'AnimationPlayer.")
