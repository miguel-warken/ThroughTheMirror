extends Area2D

func _on_key_body_entered(body):
	if body.is_in_group("Escalador"):
		body.keyCollected = true
		print(body.keyCollected)
		queue_free()
