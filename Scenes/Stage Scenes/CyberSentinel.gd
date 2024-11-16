extends Node2D

signal battle_started
const battle_arena_scene = preload("res://Scenes/CombatArena.tscn")

func _enter_battle():
	#emit_signal("battle_started")
	#var combat_arena = battle_arena_scene.instance()
	#add_child(combat_arena)
	#combat_arena.connect("victory", self, "_on_battle_end")
	#print("Combat started!")
	pass
