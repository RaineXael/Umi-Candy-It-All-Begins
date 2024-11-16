extends Node2D 

@export var player: OverworldPlayer
@export var delay_frames: int = 10  

func _physics_process(delta: float) -> void:
	if player:
		position = player.get_last_previous_position(delay_frames, position)
