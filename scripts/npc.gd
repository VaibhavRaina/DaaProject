extends CharacterBody2D
@onready var player = $"../Player"

@onready var navigation_agent_2d = $NavigationAgent2D
var speed = 50
@export var target: Node2D = null
@onready var animated_sprite_2d = $AnimatedSprite2D



func _ready():
	call_deferred("npc_setup") # wait a bit to start the movement

func npc_setup():
	await get_tree().physics_frame # wait a physics frame or frame then execute
	#if target:
		#navigation_agent_2d.target_position = target.global_position
	
func acquire_food():
	
	var food_container = get_tree().get_nodes_in_group("food")[0]
	var available_food = food_container.get_children()
	
	if !available_food.is_empty():
		var new_target = available_food[0]
		target = new_target
	else:
		target=player
	navigation_agent_2d.target_position = target.global_position
func _physics_process(delta):
	#if is_instance_valid(target):
		#navigation_agent_2d.target_position = target.global_position
	#else:
	acquire_food()

	if navigation_agent_2d.is_navigation_finished():
		return

	var current_agent_position = global_position
	var next_agent_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_agent_position) * speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)

	if velocity.x == 0:
		animated_sprite_2d.play("idle")
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("move")
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("move")

	move_and_slide()




func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity=safe_velocity
