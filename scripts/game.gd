extends Node2D

@onready var bg: ColorRect = $Control/ColorRect
@onready var black: Color = Color(0,0,0)
@onready var white: Color = Color(1,1,1)

@onready var w_tilemap: TileMap = $Level1/WhiteTileMap
@onready var b_tilemap: TileMap = $Level1/BlackTileMap

@onready var bspike: Area2D = $Level1/bspike
@onready var wsprite: Area2D = $Level1/wspike

# Called when the node enters the scene tree for the first time.
func _ready():
	#Iniciar com fundo preto
	bg.color = Color(0,0,0)
	invert_bg()
	invert_tiles()




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
		bspike.set_collision_mask_value(1, false)
	else:
		bg.color = black 
		b_tilemap.tile_set.set_physics_layer_collision_layer(0,2)
		w_tilemap.tile_set.set_physics_layer_collision_layer(0,0)
		bspike.set_collision_mask_value(1, true)



func invert_tiles() -> void:
	if(bg.color == white):
		w_tilemap.visible = true
		b_tilemap.visible = false
	else:
		w_tilemap.visible = false
		b_tilemap.visible = true


