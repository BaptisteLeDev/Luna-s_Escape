extends Node

@export var node: Node  # Nœud parent pour ajouter les scènes/niveaux
@export var levels: Array[PackedScene]  # Liste des niveaux (PackedScene)
var index = 0  # Index pour suivre le niveau actuel
var current_level
@export var menu_scene: PackedScene  # Scène du menu à recharger

# Fonction appelée depuis le menu pour commencer le jeu
func _on_menu_start_game() -> void:
	change_level()  # Change le niveau
	print(levels.size())

func _on_ui_next_lv() -> void:
	# Supprimer la scène actuelle et charger la suivante
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
		reload_menu()

# Fonction pour recharger le menu
func reload_menu() -> void:
	if current_level:
		current_level.queue_free()  # Supprime le dernier niveau (au cas où)
	# Instancie et ajoute le menu au parent
	var menu = menu_scene.instantiate()
	node.add_child(menu)
	index = 0  # Réinitialise l'index des niveaux
	print("Retour au menu.")

# Fonction pour retourner au menu depuis n'importe où
func return_to_menu() -> void:
	# Supprimer tous les enfants du conteneur des niveaux
	for child in node.get_children():
		child.queue_free()

	# Charger la scène Menu
	var menu = menu_scene.instantiate()

	# Ajouter la scène Menu directement sous "Main"
	var main = get_tree().root.get_node("Main")  # Nom exact de ton nœud principal
	main.add_child(menu)
	print("Menu ajouté au bon endroit !")
