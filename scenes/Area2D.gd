extends Area2D

@onready var destino : CollisionShape2D = $destino

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Escalador"):
		body.global_position = destino.global_position
		body.get_node("Camera2D").global_position = destino.global_position
		destino.queue_free()
