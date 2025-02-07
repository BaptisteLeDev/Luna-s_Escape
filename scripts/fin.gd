extends Node2D

signal theEnd

func _ready() -> void:
	emit_signal("theEnd")
	var anim_player = $Voiture/AnimationPlayer

	# Vérifie si une animation existe avant de la jouer
	if anim_player.has_animation("car_end"):
		anim_player.play("car_end")
		
		# Attend la fin de l'animation avant de continuer
		await anim_player.animation_finished
		
		# Ajoute un délai de 5 secondes
		await get_tree().create_timer(5.0).timeout
		
		print("Fin du délai, fermeture du jeu.")
		get_tree().quit()
	else:
		print("Animation 'car_end' non trouvée dans l'AnimationPlayer.")
