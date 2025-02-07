extends Node2D

func _ready() -> void:
	var anim_player = $Voiture/AnimationPlayer

	# Vérifie si une animation existe avant de la jouer
	if anim_player.has_animation("car_end"):
		anim_player.play("car_end")
	else:
		print("Animation 'car_end' non trouvée dans l'AnimationPlayer.")
