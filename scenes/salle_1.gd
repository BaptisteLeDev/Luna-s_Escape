extends Node2D

var is_open = false  # État du coffre (fermé par défaut)

func _ready():
	# Initialise l'état du coffre et le texte du Label
	$"TombeauFermé".visible = false

func _process(delta):
	# Met à jour le temps restant si le timer est actif
	pass


func update_coffre_state():
	# Met à jour l'état du coffre (ouvert/fermé)
	if is_open:
		$TombeauOuvert.visible = false  # Masquer le coffre fermé
		$"TombeauFermé".visible = true  # Afficher le coffre ouvert
	else:
		$TombeauOuvert.visible = true  # Afficher le coffre fermé
		$"TombeauFermé".visible = false  # Masquer le coffre ouvert

func _on_tombeau_ouvert_tombeau_close() -> void:
	is_open = not is_open
	update_coffre_state()

func return_to_menu() -> void:
	# Récupérer le nœud principal (Main)
	var main_node = get_tree().get_root().get_node("Main")  # Assure-toi que le nom du nœud principal est "Main"
	
	# Vérifie que le nœud principal existe et appelle la fonction "return_to_menu"
	if main_node and main_node.has_method("return_to_menu"):
		main_node.call("return_to_menu")
	else:
		print("Erreur : Impossible de retourner au menu (Main ou méthode manquante).")
