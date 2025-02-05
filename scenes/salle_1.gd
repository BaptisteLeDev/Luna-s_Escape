extends Node2D

var is_open = false  # État du coffre (fermé par défaut)

func _ready():
	# Le coffre est fermé au début, donc on masque le sprite "ouvert"
	$"TombeauFermé".visible = false



func update_coffre_state():
	if is_open:
		$TombeauOuvert.visible = false  # Masquer le coffre fermé
		$"TombeauFermé".visible = true  # Afficher le coffre ouvert
	else:
		$TombeauOuvert.visible = true  # Afficher le coffre fermé
		$"TombeauFermé".visible = false  # Masquer le coffre ouvert


func _on_tombeau_ouvert_tombeau_close() -> void:
	is_open = not is_open
	update_coffre_state()
