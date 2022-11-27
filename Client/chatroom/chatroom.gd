extends Control

onready var chatlog = $CenterContainer/VBoxContainer/ChatLog

func player_joined(player_name):
	chatlog.add_item("New Chatter Joined: " + player_name)
