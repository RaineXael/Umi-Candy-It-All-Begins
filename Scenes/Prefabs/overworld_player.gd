class_name OverworldPlayer
extends CharacterBody2D

@export_category('Movement Variables')
var SPEED = 160.0



@onready var animator = $UmiSprite
enum directions{UP, DOWN, LEFT, RIGHT}
var last_direction:directions = directions.DOWN
var moving = false
#for followers
const MAX_POSITIONS = 100
var prev_positions = []
@onready var initial_pos = position
const character_sprites = ["res://Animations/overworld_actors/players/overworld_umi.tres", 
"res://Animations/overworld_actors/players/overworld_candy.tres"]



func _physics_process(delta: float) -> void:
	
	handle_movement()
	handle_animations()
	update_previous_positions()
	
	#Testing character switching (without follower)
	if Input.is_action_just_pressed("Player_Switch_Umi"):
		switch_character('umi')
	if Input.is_action_just_pressed("Player_Switch_Candy"):
		switch_character('candy')
	
	
	move_and_slide()


func handle_movement():
	var direction := Vector2(Input.get_axis("Player_Left", "Player_Right"), Input.get_axis("Player_Up", "Player_Down"))
	
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
func handle_animations():
	#animation handler
	if velocity.length_squared() > 0:
		#moving, start playing animation
		if velocity.y > 0: 
			animator.play('walk_down')
			last_direction = directions.DOWN
		elif velocity.y < 0:
			animator.play('walk_up')
			last_direction = directions.UP
		elif velocity.x > 0: 
			animator.play('walk_right')
			last_direction = directions.RIGHT
		elif velocity.x < 0:
			animator.play('walk_left')
			last_direction = directions.LEFT
		moving = true
	else:
		animator.stop()
		animator.frame = 5
		moving = false
	
func switch_character(char:String):
	#Switches the sprite to any of the characters.
	#For now, just changes the sprite
	if char.to_lower() == 'umi':
		animator.sprite_frames = load(character_sprites[0])
	elif char.to_lower() == 'candy':
		animator.sprite_frames = load(character_sprites[1])
	#The other 2 chars aren't present in the demo so they can't be added
	else:
		printerr('Invalid Character Name.')

#Position saving logic for followers
func get_last_previous_position(offset: int, pos:Vector2) -> Vector2: 
	if prev_positions.is_empty() or offset >= prev_positions.size():
		return pos
	return prev_positions[max(0, prev_positions.size() - 1 - offset)]
func update_previous_positions() -> void:
	# Add the current position to the array of positions, removing old ones
	if moving: 
		prev_positions.append(position)
		if prev_positions.size() > MAX_POSITIONS:
			prev_positions.pop_front()
