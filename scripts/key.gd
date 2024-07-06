extends Area2D

func _on_key_body_entered(body):
	body.keyCollected = true
	print(body.keyCollected)
	queue_free()
