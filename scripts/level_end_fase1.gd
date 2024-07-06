extends Area2D


#func _on_level_end_body_entered(body):
	#print("Esta")
	#if(player.keyCollected):
		#print("aaaaeeeeeeeaeaeaeg")
		#call_deferred("goto_scene", "res://scenes/level_2.tscn")
#var currentScene = get_tree().get_current_scene()
#
#func goto_scene(path: String):
	#
	#$Level1.queue_free()
	#var res := ResourceLoader.load(path)
	#currentScene = res.instantiate()	
	#add_child(currentScene)
#
#func _on_body_entered(body):
	#if body.keyCollected and body.is_in_group("Escalador"):
		#call_deferred("goto_scene", "res://scenes/level_2.tscn")
#


var on_door := false
func _on_body_exited(body):
	on_door = false
	print("Saiu")


func _on_body_entered(body):
	on_door = true
	if on_door and body.keyCollected:
		get_tree().change_scene_to_file("res://scenes/"+self.name+".tscn")
	print("Esta")
	
#func _process(body):
	#if on_door and body.keyCollected:
		#get_tree().change_scene_to_file("res://scenes/"+self.name+".tscn")
