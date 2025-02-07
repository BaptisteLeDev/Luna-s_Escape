extends CanvasLayer

signal on_transition_finished  # Signal émis à la fin de la transition

@onready var color_rect = $ColorRect  # Rectangle pour l'effet de fondu
@onready var animation_player = $AnimationPlayer  # Animation pour les transitions

func _ready():
	if color_rect == null:
		print("Erreur : le ColorRect est introuvable.")
	else:
		color_rect.visible = false
	
	# Connecte l'animation_player au signal animation_finished
	animation_player.animation_finished.connect(_on_animation_finished)

# Fonction pour lancer la transition
func transition():
	color_rect.visible = true  # Rendre le rectangle visible
	print("Début de la transition fade_to_black")
	animation_player.play("fade_to_black")  # Jouer l'animation de transition

func fade_back():
	print("Début de la transition fade_to_game")
	animation_player.play("fade_to_game")  # Joue l'animation pour revenir

# Fonction appelée lorsque l'animation est terminée
func _on_animation_finished(anim_name: String) -> void:
	print("Animation terminée :", anim_name)
	if anim_name == "fade_to_black":  # Vérifie si l'animation terminée est celle attendue
		on_transition_finished.emit()  # Émet le signal pour indiquer que la transition est terminée
		color_rect.visible = false  # Cache à nouveau le rectangle
	elif anim_name == "fade_to_game":
		color_rect.visible = false

func start_transition(callback: Callable):
	print("Début de start_transition")
	color_rect.visible = true
	animation_player.play("fade_to_black")
	on_transition_finished.connect(callback)
