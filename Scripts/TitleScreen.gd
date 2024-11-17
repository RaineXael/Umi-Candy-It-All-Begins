extends Control

func _on_StartButton_pressed():
	#get_tree().change_scene_to_file("res://Scenes/Menu Scenes/SaveMenu.tscn")
	#No save yet :( better to just start the game
	#the 4.3 upgrade borked it anyways better to start anew
	get_tree().change_scene_to_file("res://Scenes/Stage Scenes/CyberSentinel.tscn")
	pass # Replace with function body.
	
func _on_CloseButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
	
func _on_OptionsButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu Scenes/OptionsMenu.tscn")
	pass # Replace with function body.
	
func _on_Credits_pressed():
	OS.shell_open("https://www.umiandcandy.com/meet-the-team")
	pass # Replace with function body.

func _on_Discord_pressed():
	OS.shell_open("https://discord.gg/Q7brEVK4mK")
	pass # Replace with function body.
	
func _on_Twitter_pressed():
	OS.shell_open("https://twitter.com/Blue_Star_Games")
	pass # Replace with function body.
	
func _on_Itchio_pressed():
	OS.shell_open("https://therealbluestar.itch.io/")
	pass # Replace with function body.
