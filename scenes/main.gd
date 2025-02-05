extends Node

@export var node: Node  # Nœud parent pour ajouter les scènes/niveaux
@export var levels: Array[PackedScene]  # Liste des niveaux (PackedScene)
var index = 0  # Index pour suivre le niveau actuel
var current_level

# Fonction appelée depuis le menu pour commencer le jeu
func _on_menu_start_game() -> void:
	change_level()  # Change le niveau

func _on_ui_next_lv() -> void:
	# Lancer la transition pour charger la nouvelle scènetransition.transition_to_scene(next_scene)
	current_level.queue_free()
	change_level()  # Change le niveau


# Fonction pour changer de niveau
func change_level() -> void:
	if index < levels.size():
		current_level = levels[index].instantiate()
		node.add_child(current_level)  # Ajouter le niveau au nœud parent
		index += 1  # Passer au niveau suivant
		print("Niveau actuel :", index)
	else:
		print("Tous les niveaux ont été chargés.")
