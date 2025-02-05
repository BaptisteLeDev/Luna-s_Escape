extends Node2D

var is_open = false  # État du coffre (fermé par défaut)
@onready var timer = $Timer  # Assure-toi que ta salle a un Timer nommé "Timer"

func _ready():
	# Configure et démarre le Timer pour 2 minutes
	timer.wait_time = 120.0  # 120 secondes (2 minutes)
	timer.one_shot = true  # Le Timer ne se relance pas automatiquement
	timer.start()
	# Connecte le signal "timeout" du Timer
	timer.timeout.connect(_on_timer_timeout)

	# Le coffre est fermé au début, donc on masque le sprite "ouvert"
	$"TombeauFermé".visible = true  # Assure-toi que l'état initial est correct
	$TombeauOuvert.visible = false

func _on_timer_timeout():
	print("Temps écoulé ! Retour au menu...")
	# Ici, tu peux appeler une méthode du Main pour revenir au menu principal.
	var main = get_tree().root.get_node("Main")  # Remplace "Main" par le nom exact
	main.reload_menu()

func update_coffre_state():
	if is_open:
		$TombeauOuvert.visible = false  # Masquer le coffre ouvert
		$"TombeauFermé".visible = true  # Afficher le coffre fermé
	else:
		$TombeauOuvert.visible = true  # Afficher le coffre ouvert
		$"TombeauFermé".visible = false  # Masquer le coffre fermé

func _on_tombeau_ouvert_tombeau_close() -> void:
	is_open = not is_open
	update_coffre_state()
