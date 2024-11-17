extends Node2D 

enum Directions { UP, DOWN, LEFT, RIGHT }
@onready var animator = $UmiSprite
@export var player: OverworldPlayer
@export var delay_frames: int = 10  

@onready var previous_position = position #for walking anims
var previous_direction = Directions.DOWN

var moving = false
func _physics_process(delta: float) -> void:
	if player:
		position = player.get_last_previous_position(delay_frames, position)
		
	
	var direction = determine_direction(previous_position, position)
	if direction == Directions.UP:
		if moving: 
			animator.play('walk_up')
		else:
			animator.stop()
			animator.frame = 4
	elif direction == Directions.DOWN:
		if moving: 
			animator.play('walk_down')
		else:
			animator.stop()
			animator.frame = 4
	elif direction == Directions.LEFT:
		if moving: 
			animator.play('walk_left')
		else:
			animator.stop()
			animator.frame = 4
	elif direction == Directions.RIGHT:
		if moving: 
			animator.play('walk_right')
		else:
			animator.stop()
			animator.frame = 4
	previous_position = position
	previous_direction = direction

#returns which direction the obj was moving based on current and previous pos
func determine_direction(previous_position: Vector2, current_position: Vector2) -> int:
	var movement_vector = current_position - previous_position
	if movement_vector.length_squared() == 0:
		moving = false
		return previous_direction
	moving = true
	if abs(movement_vector.x) > abs(movement_vector.y):
		if movement_vector.x > 0:
			return Directions.RIGHT
		else:
			return Directions.LEFT
	else:
		if movement_vector.y > 0:
			return Directions.DOWN
		else:
			return Directions.UP
