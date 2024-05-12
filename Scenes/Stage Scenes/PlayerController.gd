extends KinematicBody2D

export (int) var speed = 300

enum {UMI, CANDY}
var selected_character = UMI

var player_sprites
var player_characters
var party_size = 2
var prev_pos = [Vector2(0,0),Vector2(1,1),Vector2(2,2),Vector2(3,3),Vector2(4,4)]
var pos_ptr = 0
var prev_dir
var follow_distance = 100

var velocity = Vector2()

func _ready():
	player_sprites = [$UmiSprite/UmiOverworldAnim, $CandySprite/CandyOverworldAnim]
	player_characters = [$UmiSprite, $CandySprite]

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Player_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Player_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Player_Down"):
		velocity.y += 1
	if Input.is_action_pressed("Player_Up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	player_characters[selected_character].z_index = 0
	if Input.is_action_pressed("Player_Switch_Umi"):
		selected_character = UMI
		player_characters[UMI].global_position = global_position
	if Input.is_action_pressed("Player_Switch_Candy"):
		selected_character = CANDY
		player_characters[CANDY].global_position = global_position
	player_characters[selected_character].z_index = 1
	
	move_party(velocity)
	

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func move_party(velocity):
	if (velocity.length() == 0):
		player_sprites[UMI].play("IdleAnim")
		player_sprites[CANDY].stop()
	else:
		var dir = int(round(velocity.angle() / PI * 2))
		var other_char = (selected_character + 1) % party_size
		if dir != prev_dir:
			pos_ptr = (pos_ptr + 1) % 5
			prev_pos[pos_ptr] = global_position
			prev_dir = dir
		var partial_sum = (global_position - prev_pos[pos_ptr]).length()
		if (partial_sum >= follow_distance):
			var lambda
			if ((global_position - prev_pos[pos_ptr]).length() < 0.01):
				lambda = 0
			else:
				lambda = 1 - (partial_sum-follow_distance) / (global_position - prev_pos[pos_ptr]).length()
			player_characters[other_char].global_position\
				= global_position + lambda * (prev_pos[(pos_ptr) % 5] - global_position)
			play_animation(player_sprites[other_char], int(round((global_position - prev_pos[pos_ptr]).angle() / PI * 2)))
		else:
			for i in range(1,5):
				partial_sum += (prev_pos[(pos_ptr - i + 1) % 5] - prev_pos[(pos_ptr - i) % 5]).length()
				if (partial_sum >= follow_distance):
					var lambda = 1 - (partial_sum-follow_distance) / (prev_pos[(pos_ptr - i + 1) % 5] - prev_pos[(pos_ptr - i) % 5]).length()
					player_characters[other_char].global_position = prev_pos[(pos_ptr - i + 1) % 5] + lambda * (prev_pos[(pos_ptr - i) % 5] - prev_pos[(pos_ptr - i + 1) % 5])
					play_animation(player_sprites[other_char], int(round((prev_pos[(pos_ptr - i + 1) % 5] - prev_pos[(pos_ptr - i) % 5]).angle() / PI * 2)))
					break
		play_animation(player_sprites[selected_character], dir)
		
func play_animation(animationPlayer, dir):
	match dir:
			0:
				animationPlayer.play("RightWalk")
			2:
				animationPlayer.play("LeftWalk")
			-2:
				animationPlayer.play("LeftWalk")
			1:
				animationPlayer.play("ForwardWalk")
			-1:
				animationPlayer.play("BackwardWalk")
