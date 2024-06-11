extends Node2D


@onready var texture = $texture
@onready var area_sign = $area_sign

const lines : Array[String] = [
	"Olá,aventureiro!"
]



func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && DialogMananger.is_message_active:
			texture.hide()
			DialogMananger.start_message(global_position, lines)
			print("Pateta")
	else:
		texture.hide()
		if DialogMananger.dialog_box != null:
			DialogMananger.dialog_box.queue_free()
			DialogMananger.is_message_active = false

