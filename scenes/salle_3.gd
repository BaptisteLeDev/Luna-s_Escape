extends Node2D
@onready var switch_wall = $Sprite_Mur
signal SalleFinished  # Signal émis lorsque la salle est terminée

var red_snake := false
var blu_snake := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sortie_salle3() -> void:
	switch_wall.texture = load("res://assets/images/niveau 3 sortie final.png")
	print('open')
	emit_signal("SalleFinished")

func _on_corde_3_corde_3() -> void:
	GlobalTimer
	


func _on_plan_de_travail_2_serpent_red_snak() -> void:
	if red_snake :
		pass
	else :
		red_snake=true
	if  red_snake && blu_snake :
		sortie_salle3()
	


func _on_plan_de_travail_6_serpent_blu_snak() -> void:
	if blu_snake :
		pass
	else :
		blu_snake=true
	if  red_snake && blu_snake :
		sortie_salle3()
