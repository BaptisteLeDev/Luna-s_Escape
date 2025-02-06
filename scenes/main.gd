extends Node

@export var node: Node  # Nœud parent pour ajouter les scènes/niveaux (ex. "Game")
@export var levels: Array[PackedScene]  # Liste des niveaux (PackedScene)
@export var menu_scene: PackedScene  # Scène du menu à recharger
var index = 0  # Index pour suivre le niveau actuel
var current_level
signal nextUi  # Signal pour indiquer que l'UI doit passer au niveau suivant

func _ready() -> void:
	pass
# Fonction appelée depuis le menu pour commencer le jeu
func _on_menu_start_game() -> void:
	change_level()  # Charger le premier niveau

# Fonction appelée pour passer au niveau suivant
func _on_ui_next_lv() -> void:
	if current_level:
		current_level.queue_free()  # Supprime le niveau actuel
	change_level()  # Charger le niveau suivant

# Fonction pour changer de niveau
func change_level() -> void:
	if current_level != null:
		current_level.queue_free()  # Libère le niveau précédent avant d'ajouter le nouveau

	if index < levels.size():
		current_level = levels[index].instantiate()
		node.add_child(current_level)
		index += 1
		print("Niveau actuel :", index)
		current_level.connect("SalleFinished", Callable(self, "_on_level_finished"))
	else:
		print("Tous les niveaux ont été chargés.")
		reload_menu()


# Méthode appelée lorsque le niveau est terminé
func _on_level_finished() -> void:
	print("Niveau terminé, signal envoyé à l'UI")
	emit_signal("nextUi")  # Émet le signal pour l'UI

# Fonction pour recharger le menu
func reload_menu() -> void:
	if current_level:
		current_level.queue_free()  # Supprime le dernier niveau
	var menu = menu_scene.instantiate()
	node.add_child(menu)  # Ajoute le menu au nœud parent
	index = 0  # Réinitialise l'index des niveaux
	print("Retour au menu.")

# Fonction pour retourner au menu depuis n'importe où
func return_to_menu() -> void:
	for child in node.get_children():
		child.queue_free()  # Supprime tous les enfants
	reload_menu()
