extends CharacterBody2D


const SPEED = 150.0
const JUMP_FORCE = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var knockback_vector := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction
var directionY
@export var keyCollected = false

@export var climbing = false

@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

@onready var heartsTexture = $Level2/ui/Life

signal life_changed(player_heart)
var player_life := 5
var hearts_shown = player_life
var is_jumping := false
var is_hurted := false

func _ready() -> void:
	var ui_life = get_parent().get_node(heartsTexture)
	if ui_life:
		ui_life.connect("life_changed", Callable(self, "_on_player_life_changed"))
		emit_signal("life_changed", player_life)
		print("Funciona")
	else:
		print("Erro: O nó 'ui/Life' não foi encontrado.")
	#connect("life_changed", get_parent().get_node("ui/Life"),"on_player_life_changed")
	#emit_signal("life_changed", player_life)


func _physics_process(delta):
	if climbing == false:
		velocity.y += gravity * delta
	elif climbing == true:
		velocity.y = 0
		if Input.is_action_pressed("up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("down"):
			velocity.y = SPEED
		if Input.is_action_just_pressed("jump"):
			climbing = false
			velocity.y = JUMP_FORCE
			is_jumping = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	_set_state()
	move_and_slide()

	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)



func _on_hurtbox_body_entered(body: Node2D) -> void:
	if player_life <= 0:
		get_tree().reload_current_scene()
	else :
		if $ray_right.is_colliding():
			print("colisor right")
			take_damage(Vector2(-200,-200))
		elif $ray_left.is_colliding():
			print("colisor left")
			take_damage(Vector2(200,-200))
		elif $ray_down.is_colliding():
			print("colisor down")
			take_damage(Vector2(0, -200))
		elif $ray_up.is_colliding():
			print("colisor up")
			take_damage(Vector2(0, gravity/2))

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	hearts_shown -=1
	emit_signal("life_changed", hearts_shown)
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
	is_hurted = true
	await  get_tree().create_timer(.3).timeout
	is_hurted = false
func _set_state():
	var state = "idle"
	
	if !is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"
	
	if is_hurted:
		state = "hurt"
	
	if animation.name != state:
		animation.play(state)


func _on_head_collider_body_entered(body):
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			body.create_coin()


func _on_key_body_entered(body):
	keyCollected = true


#func _on_ladder_body_entered(body):
	#print("escada")
	#directionY = Input.get_axis("up","down")
	#
	#if directionY != 0:
		#velocity.y = directionY * SPEED
		#animation.scale.y = direction
	#else:
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		#
	#_set_state()
	#move_and_slide()
