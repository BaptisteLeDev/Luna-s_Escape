extends Node2D
@onready var switch_wall = $Sprite_Mur
signal SalleFinished  # Signal émis lorsque la salle est terminée


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_corde_corde() -> void:
	switch_wall.texture = load("res://assets/images/Salle_2/piege eau fermé-8.png")
	print('open')
	emit_signal("SalleFinished")

func _on_corde_3_corde_3() -> void:
	GlobalTimer
	
