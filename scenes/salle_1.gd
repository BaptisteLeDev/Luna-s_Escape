extends Node2D

var is_open = false  # État du coffre (fermé par défaut)
@onready var timer = $Timer  # Assure-toi que ta salle a un Timer nommé "Timer"
@onready var timer_label = $Timer/TimerLabel  # Label pour afficher le temps restant
var remaining_time = 120.0  # Temps total en secondes (initialisé à 120)

func _ready():
	# Vérifie si le Timer est bien référencé
	if not timer:
		print("Erreur : Le nœud Timer n'a pas été trouvé ! Vérifie la hiérarchie de la scène.")
		return
	
	# Configure et démarre le Timer pour 2 minutes
	timer.wait_time = remaining_time
	timer.one_shot = true  # Le Timer ne se relance pas automatiquement
	timer.start()

	# Connecte le signal "timeout" du Timer
	timer.timeout.connect(_on_timer_timeout)

	# Initialise l'état du coffre et le texte du Label
	$"TombeauFermé".visible = false
	update_timer_label(remaining_time)

func _process(delta):
	# Met à jour le temps restant si le timer est actif
	if timer.is_stopped() == false:
		remaining_time -= delta
		update_timer_label(remaining_time)

func _on_timer_timeout():
	print("Temps écoulé ! Retour au menu...")
	# Appelle la fonction pour retourner au menu principal
	return_to_menu()

func update_timer_label(time_left: float) -> void:
	# Met à jour le texte du Label avec le temps restant formaté en minutes:secondes
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "Temps restant : %02d:%02d" % [minutes, seconds]

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
