extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Escalador") and body.keyCollected:
			print("tenho chave")
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
			#acaba o jogo

