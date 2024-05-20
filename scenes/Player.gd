extends CharacterBody2D

@export var speed = 100.0

@onready var sprite = $PlayerSprite

func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func animate():
	if velocity.x != 0 && velocity.y == 0:
		sprite.play("running")
	elif velocity.y != 0:
		sprite.play("climb")
	else:
		sprite.play("idle")
		
func move_8way(delta):
	get_8way_input()
	animate()
	move_and_slide()

func _physics_process(delta):
	move_8way(delta)
