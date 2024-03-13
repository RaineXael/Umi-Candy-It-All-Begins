extends KinematicBody2D

export (int) var speed = 300

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Player_Right"):
		velocity.x += 1
		$CandySprite/CandyOverworldAnim.play("CandyRightWalk")
	if Input.is_action_pressed("Player_Left"):
		velocity.x -= 1
		$CandySprite/CandyOverworldAnim.play("CandyLeftWalk")
	if Input.is_action_pressed("Player_Down"):
		velocity.y += 1
		$CandySprite/CandyOverworldAnim.play("CandyForwardWalk")
	if Input.is_action_pressed("Player_Up"):
		velocity.y -= 1
		$CandySprite/CandyOverworldAnim.play("CandyBackwardWalk")
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

