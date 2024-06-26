extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var camera_2d = $PhantomCamera2D
@export var Food: PackedScene

var speed = 500
var acceleration = 40
var input = Vector2.ZERO

func get_input():
	input.x = int(Input.is_action_pressed("move_east")) - int(Input.is_action_pressed("move_west"))
	input.y = int(Input.is_action_pressed("move_south")) - int(Input.is_action_pressed("move_north"))
	return input.normalized()

func _physics_process(delta):
	var player_input = get_input()
	velocity = lerp(velocity, speed * player_input, acceleration * delta)
	move_and_slide()
	animation()

func animation():
	var player_input = get_input()
	if player_input.x == 0 and player_input.y == 0:
		animation_player.speed_scale = 0.2
		animation_player.play("idle")
	elif player_input.x > 0:
		animation_player.speed_scale = 1.5
		animation_player.play("walk_east")
	elif player_input.x < 0:
		animation_player.speed_scale = 1.5
		animation_player.play("walk_west")
	elif player_input.y > 0:
		animation_player.speed_scale = 1.5
		animation_player.play("walk_south")
	elif player_input.y < 0:
		animation_player.speed_scale = 1.5
		animation_player.play("walk_north")

func _input(event):
	if Input.is_action_just_pressed("food"):
		var instance = Food.instantiate()
		instance.global_position = global_position
		var foodCollection = get_tree().get_nodes_in_group("food")[0]
		foodCollection.add_child(instance)
	if Input.is_action_just_pressed("zoom in"):
		var zoom_val = camera_2d.zoom.x + 0.1
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
	elif Input.is_action_just_pressed("zoom out"):
		var zoom_val = camera_2d.zoom.x - 0.1
		camera_2d.zoom = Vector2(zoom_val, zoom_val)
