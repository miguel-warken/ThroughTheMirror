extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Escalador") and body.keyCollected:
			print("tenho chave")
			get_tree().change_scene_to_file("res://scenes/level_1.tscn")
			#acaba o jogo

