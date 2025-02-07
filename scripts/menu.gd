extends Control

@export var node : Node

signal startGame

func _on_start_btn_button_down() -> void:
	queue_free()
	startGame.emit()
	
	
func _on_sortir_btn_button_down() -> void:
	get_tree().quit()
