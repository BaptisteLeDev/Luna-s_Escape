extends Node2D

@onready var switch_wall = $Sprite_Mur
var is_open = false  # État du coffre (fermé par défaut)
signal SalleFinished  # Signal émis lorsque la salle est terminée

func _ready():
	$"TombeauFermé".visible = false  # Initialise l'état du coffre

func update_coffre_state():
	# Met à jour l'état du coffre (ouvert/fermé)
	if is_open:
		$TombeauOuvert.visible = false
		$"TombeauFermé".visible = true
		# Charger la texture à partir du fichier et l'assigner au sprite
		switch_wall.texture = load("res://assets/images/Salle_1/Pièce tombeau 5XX.svg")
		print('open')
	else:
		$TombeauOuvert.visible = true
		$"TombeauFermé".visible = false

func _on_tombeau_ouvert_tombeau_close() -> void:
	is_open = not is_open
	update_coffre_state()
	emit_signal("SalleFinished")
