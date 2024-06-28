extends Area2D

var climbing = false

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Escalador")):
		if body.climbing == false:
			body.climbing = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Escalador")):
		if body.climbing == true:
			body.climbing = false
	pass # Replace with function body.
