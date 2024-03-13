extends KinematicBody2D

export (int) var speed = 300

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Player_Right"):
		velocity.x += 1
		$UmiSprite/UmiOverworldAnim.play("UmiRightWalk")
	if Input.is_action_pressed("Player_Left"):
		velocity.x -= 1
		$UmiSprite/UmiOverworldAnim.play("UmiLeftWalk")
	if Input.is_action_pressed("Player_Down"):
		velocity.y += 1
		$UmiSprite/UmiOverworldAnim.play("UmiForwardWalk")
	if Input.is_action_pressed("Player_Up"):
		velocity.y -= 1
		$UmiSprite/UmiOverworldAnim.play("UmiBackwardWalk")
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
