extends CanvasLayer

var duration = 1.0  # Durée de la transition en secondes
var callback = null  # Fonction à appeler après la transition

func fade_in():
	$ColorRect.modulate.a = 1  # Commence complètement opaque
	$ColorRectTween.tween_property($ColorRect, "modulate:a", 0, duration)
	$ColorRectTween.start()

func fade_out():
	$ColorRect.modulate.a = 0  # Commence transparent
	$ColorRectTween.tween_property($ColorRect, "modulate:a", 1, duration)
	$ColorRectTween.start()

func start_transition(func_to_call):
	callback = func_to_call
	fade_out()

func _on_ColorRectTween_tween_completed(object, key):
	# Si la transition est terminée, on exécute la fonction passée en callback
	if key == "modulate:a" and callback != null:
		callback()
		fade_in()
