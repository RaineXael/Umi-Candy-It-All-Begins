extends CharacterBody2D

const SPEED = 140.0
@onready var animator = $UmiSprite
enum directions{UP, DOWN, LEFT, RIGHT}
var last_direction:directions = directions.DOWN
func _physics_process(delta: float) -> void:

	var direction := Vector2(Input.get_axis("Player_Left", "Player_Right"), Input.get_axis("Player_Up", "Player_Down"))
	
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

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
	else:
		animator.stop()
		animator.frame = 4
	
	move_and_slide()
