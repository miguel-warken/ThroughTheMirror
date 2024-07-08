extends Node


@onready var bg: ColorRect = $Background/ColorRect
@onready var black: Color = Color(0,0,0)
@onready var white: Color = Color(1,1,1)

@onready var w_tilemap: TileMap = $WhiteTileMap
@onready var b_tilemap: TileMap = $BlackTileMap

@onready var b_spikes: TileMap = $b_spikes
@onready var w_spikes: TileMap = $w_spikes

#@onready var b_ladder := $Level1/ladder


var player: CharacterBody2D
var currentScene = null



# Called when the node enters the scene tree for the first time.
func _ready():
	#Iniciar com fundo preto
	bg.color = Color(1,1,1)
	invert_bg()
	invert_tiles()
	player = $player




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("click")):
		invert_bg()
		invert_tiles()
		
		
		


func invert_bg() -> void:
	var bg_curr_color: Color = bg.color
	
	if(bg_curr_color == black):
		bg.color = white
		b_tilemap.tile_set.set_physics_layer_collision_layer(0,0)
		w_tilemap.tile_set.set_physics_layer_collision_layer(0,3)
		b_spikes.tile_set.set_physics_layer_collision_layer(0,0)
		w_spikes.tile_set.set_physics_layer_collision_layer(0,7)
		#b_ladder.set_collision_mask_value(1, false)
		
	else:
		bg.color = black 
		b_tilemap.tile_set.set_physics_layer_collision_layer(0,2)
		w_tilemap.tile_set.set_physics_layer_collision_layer(0,0)
		b_spikes.tile_set.set_physics_layer_collision_layer(0,6)
		w_spikes.tile_set.set_physics_layer_collision_layer(0,0)
		#b_ladder.set_collision_mask_value(1, true)
		


func invert_tiles() -> void:
	if(bg.color == white):
		w_tilemap.visible = true
		b_tilemap.visible = false
		b_spikes.visible = false
		w_spikes.visible = true
	else:
		w_tilemap.visible = false
		b_tilemap.visible = true
		b_spikes.visible = true
		w_spikes.visible = false




func _on_level_end_body_entered(body):
	if(player.keyCollected):
		print("aaaaeeeeeeeaeaeaeg")
		call_deferred("goto_scene", "res://scenes/level_2.tscn")

func goto_scene(path: String):
	queue_free()
	var res := ResourceLoader.load(path)
	currentScene = res.instantiate()	
	add_child(currentScene)
	#_ready()
