extends Button

#@export var rooms: Array[PackedScene]
@export var rooms: Array = ["res://assets/test.jpg", "res://assets/test2.jpg"]  # Liste des chemins des textures
var current_room = 0  # Salle actuelle

func _ready():
	# Vérifie que Sprite_Mur existe
	if not $Sprite_Mur:
		print("Erreur : Sprite_Mur introuvable dans la scène.")
	update_wall()

func _on_pressed():
	# Passer à la salle suivante
	current_room = (current_room + 1) % rooms.size()
	update_wall()

func update_wall():
	# Charger la texture de la salle actuelle
	var texture = load(rooms[current_room])  # Charger la texture depuis le chemin
	if texture:
		$Sprite_Mur.texture = texture
	else:
		print("Erreur : La texture n'a pas pu être chargée. Chemin : ", rooms[current_room])
