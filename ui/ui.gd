extends Control

@export var node : Node
@onready var timer = $Timer  # Assure-toi que ta salle a un Timer nommé "Timer"
@onready var timer_label = $Timer/TimerLabel  # Label pour afficher le temps restant
var remaining_time = 10.0  # Temps total en secondes (initialisé à 120)
signal NextLv


func _ready() -> void:
	$ColorRect.visible = false 
	$"PerduSethi1ErVousARattrapé!".visible = false
	$Next_btn.visible = false
	$Restart_btn.visible = false
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
	update_timer_label(remaining_time) 

func _on_next_btn_button_down() -> void:
	
	print("Prochain niveau")
	$AudioStreamPlayer.play()  # Joue le son associé
	$ColorRect.visible = false 
	$"PerduSethi1ErVousARattrapé!".visible = false 
	NextLv.emit()


func _process(delta):
	# Met à jour le temps restant si le timer est actif
	if timer.is_stopped() == false:
		remaining_time -= delta
		update_timer_label(remaining_time)

func _on_timer_timeout():
	print("Temps écoulé ! Retour au menu...")
	$ColorRect.visible = true
	$"PerduSethi1ErVousARattrapé!".visible = true 
	$Restart_btn.visible = true

func update_timer_label(time_left: float) -> void:
	# Met à jour le texte du Label avec le temps restant formaté en minutes:secondes
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "Temps restant : %02d:%02d" % [minutes, seconds]


func _on_restart_btn_button_down() -> void:
	pass # Replace with function body.
