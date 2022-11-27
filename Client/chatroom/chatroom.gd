extends Control

onready var chatlog = $CenterContainer/VBoxContainer/ChatLog
onready var textEdit = $CenterContainer/VBoxContainer/HBoxContainer/TextEdit

func player_joined(player_name):
	chatlog.add_item("New Chatter Joined: " + player_name)

func receive_message(message):
	chatlog.add_item(message)

func _on_Send_pressed():
	var text = textEdit.text
	Server.send_message(textEdit.text)
	textEdit.text = ""
