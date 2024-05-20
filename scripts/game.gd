extends Node2D

@onready var bg: ColorRect = $Control/ColorRect
@onready var black: Color = Color(0,0,0)
@onready var white: Color = Color(1,1,1)

@onready var w_tilemap: TileMap = $Level1/WhiteTileMap
@onready var b_tilemap: TileMap = $Level1/BlackTileMap



# Called when the node enters the scene tree for the first time.
func _ready():
	#Iniciar com fundo preto
	bg.color = Color(0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("click")):
		invert_bg()
		invert_tiles()


func invert_bg() -> void:
	var bg_curr_color: Color = bg.color
	
	if(bg_curr_color == black):
		bg.color = white
	else:
		bg.color = black

func invert_tiles() -> void:
	if(bg.color == white):
		w_tilemap.visible = true
		b_tilemap.visible = false
	else:
		w_tilemap.visible = false
		b_tilemap.visible = true


