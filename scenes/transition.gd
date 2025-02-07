extends CanvasLayer

signal on_transition_finished  # Signal émis à la fin de la transition

@onready var color_rect = $ColorRect  # Rectangle pour l'effet de fondu
@onready var animation_player = $AnimationPlayer  # Animation pour les transitions

func _ready():
	color_rect.visible = false  # Assure que le rectangle est invisible au départ
	animation_player.animation_finished.connected(_on_animation_finished)


# Fonction pour lancer la transition
func transition():
	color_rect.visible = true  # Rendre le rectangle visible
	animation_player.play("fade_to_black")  # Jouer l'animation de transition

func fade_back():
	animation_player.play("fade_to_game")  # Joue l'animation pour revenir

# Fonction appelée lorsque l'animation est terminée
func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_to_black":  # Vérifie si l'animation terminée est celle attendue
		on_transition_finished.emit()  # Émet le signal pour indiquer que la transition est terminée
		color_rect.visible = false  # Cache à nouveau le rectangle
	elif anim_name == "fade_to_game" :
		color_rect.visible=false
		
func start_transition(callback: Callable):
	color_rect.visible = true
	animation_player.play("fade_to_black")
	on_transition_finished.connect(callback)
