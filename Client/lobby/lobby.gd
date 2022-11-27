extends Control

onready var player_name = $CenterContainer/VBoxContainer/Name
onready var label = $CenterContainer/VBoxContainer/Label

func _on_Button_pressed():
	if player_name.text.empty():
		label.text = "YOU MUST ENTER A NAME BEFORE JOINING"
		return
	Server.player_data = {"player_name": player_name.text}
	Server._connect_to_server()
