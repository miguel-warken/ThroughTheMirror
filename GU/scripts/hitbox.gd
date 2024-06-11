extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("get_velocity"):
			body.velocity.y = body.get_velocity().y + body.JUMP_FORCE
			#owner.anim.play("hurt")
			if owner.has_node("anim"):
				var anim_player = owner.get_node("anim")
				anim_player.play("hurt")
			else:
				print("Erro: Nó AnimationPlayer não encontrado.")
