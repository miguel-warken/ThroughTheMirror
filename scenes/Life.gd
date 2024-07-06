extends Control

var heart_size: int = 40

func on_player_life_changed(player_life) -> void:
	$TextureRect.rect_size.x = player_life * heart_size
