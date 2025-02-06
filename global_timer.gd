extends Node

var time_left= 120
var time_start := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time_start :
		time_left=time_left-delta
		
		
