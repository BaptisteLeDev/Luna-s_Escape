extends Node

@onready var transition = $CanvasLayer
@export var node: Node
@export var levels: Array[PackedScene]
@export var menu_scene: PackedScene
var index = 0
var current_level
signal nextUi
signal timeStart

func _ready() -> void:
	pass

func _on_menu_start_game() -> void:
	change_level()

func _on_ui_next_lv() -> void:
	if current_level:
		current_level.queue_free()
	change_level()

func change_level() -> void:
	print("Appel de change_level")
	if current_level:
		current_level.queue_free()

	if index < levels.size():
		print("Transition vers le niveau :", index)
		transition.start_transition(Callable(self, "_load_next_level"))
	else:
		print("Tous les niveaux terminés, retour au menu.")
		transition.start_transition(Callable(self, "reload_menu"))

func _load_next_level():
	current_level = levels[index].instantiate()
	node.add_child(current_level)
	index += 1
	manage_ui_visibility(current_level)
	emit_signal("timeStart")
	current_level.connect("SalleFinished", Callable(self, "_on_level_finished"))
	transition.fade_back()
		

func manage_ui_visibility(level: Node) -> void:
	if is_ui_scene(level):
		$Ui.visible = false
	else:
		$Ui.visible = true

func is_ui_scene(level: Node) -> bool:
	return level.has_meta("scene_id") and level.get_meta("scene_id") == "Ui"

func _on_level_finished() -> void:
	print("Niveau terminé, signal envoyé à l'UI")
	emit_signal("nextUi")

func reload_menu() -> void:
	transition.start_transition(Callable(self, "_load_menu_scene"))

func _load_menu_scene():
	if current_level:
		current_level.queue_free()
	var menu = menu_scene.instantiate()
	node.add_child(menu)
	index = 0
	transition.fade_back()

func return_to_menu() -> void:
	for child in node.get_children():
		child.queue_free()
	reload_menu()
