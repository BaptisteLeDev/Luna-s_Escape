extends Control

@export var node : Node

signal NextLv

func _on_next_btn_button_down() -> void:
	print("Prochain niveau")
	$AudioStreamPlayer.play()  # Joue le son associé
	NextLv.emit()
