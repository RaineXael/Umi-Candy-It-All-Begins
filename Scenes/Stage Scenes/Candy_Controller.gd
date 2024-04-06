extends KinematicBody2D
onready var umi = $'../UmiPlayer'

var speed = 300
export (int) var follow_range = 50

var velocity = Vector2()

var last_position = Vector2()
var target_position = Vector2()

func _ready():
	target_position = umi.global_position

func get_input():
	velocity = Vector2()
	if (last_position - umi.global_position).length() > follow_range:
		target_position = last_position
		last_position = umi.global_position
	velocity = target_position - global_position
	if velocity.length() < follow_range:
		velocity = Vector2()
		$CandySprite/CandyOverworldAnim.stop(true)
	else:
		match int(round(velocity.angle() / PI * 2)):
			0:
				$CandySprite/CandyOverworldAnim.play("CandyRightWalk")
			2:
				$CandySprite/CandyOverworldAnim.play("CandyLeftWalk")
			-2:
				$CandySprite/CandyOverworldAnim.play("CandyLeftWalk")
			1:
				$CandySprite/CandyOverworldAnim.play("CandyForwardWalk")
			-1:
				$CandySprite/CandyOverworldAnim.play("CandyBackwardWalk")

	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

