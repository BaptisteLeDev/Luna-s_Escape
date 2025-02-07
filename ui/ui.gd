extends Control

@export var node: Node
@onready var timer = $Timer  # Timer pour gérer le temps
@onready var timer_label = $Timer/TimerLabel  # Label pour afficher le temps restant
@onready var endPhase = "res://scenes/fin.tscn"
var remaining_time = 120.0  # Temps total en secondes
signal NextLv  # Signal pour passer au niveau suivant

func _ready() -> void:
	$ColorRect.visible = false
	$"PerduSethi1ErVousARattrapé!".visible = false
	$Next_btn.visible = false
	$Restart_btn.visible = false
	$Mommie.visible = false
	if not timer:
		print("Erreur : Le nœud Timer n'a pas été trouvé !")
		return
	# Configure et démarre le Timer
	timer.wait_time = remaining_time
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

	update_timer_label(remaining_time)

func _process(delta):
	# Met à jour le temps restant si le Timer est actif
	if not timer.is_stopped():
		remaining_time -= delta
		update_timer_label(remaining_time)

func _on_timer_timeout():
	print("Temps écoulé !")
	$ColorRect.visible = true
	$"PerduSethi1ErVousARattrapé!".visible = true
	$Restart_btn.visible = true
	$Mommie.visible = true

func _on_next_btn_button_down() -> void:
	print("Prochain niveau")
	$AudioStreamPlayer.play()
	$ColorRect.visible = false
	$"PerduSethi1ErVousARattrapé!".visible = false
	$Next_btn.visible = false
	emit_signal("NextLv")


func _on_restart_btn_button_down() -> void:
	print("Redémarrage du niveau")
	remaining_time = 60.0
	timer.start()
	$ColorRect.visible = false
	$"PerduSethi1ErVousARattrapé!".visible = false
	$Restart_btn.visible = false
	$Mommie.visible = false
	$Next_btn.visible = false
	update_timer_label(remaining_time)

func update_timer_label(time_left: float) -> void:
	# Met à jour le label avec le temps formaté
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]


func _on_main_next_ui() -> void:
	print("nextUi")
	$Next_btn.visible = true
	pass # Replace with function body.


func _on_main_time_start() -> void:
	timer.start()
	
	
