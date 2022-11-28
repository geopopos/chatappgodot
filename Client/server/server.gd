extends Node

const DEFAULT_IP = "170.187.139.169"
const DEFAULT_PORT = 3234


var network = NetworkedMultiplayerENet.new()
var selected_ip
var selected_port

var local_player_id = 0
sync var players = {}
sync var player_data = {}

onready var Chatroom = preload("res://chatroom/chatroom.tscn")
var chatroom

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connection_failed", self, "_connected_failed")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _connect_to_server():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	network.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(network)
	var chatroom = Chatroom.instance()
	get_tree().get_root().add_child(chatroom)
	get_tree().get_root().get_node("Lobby").queue_free()

func _player_connected(id):
	print("Player " + str(id) + " Connected")

func _player_disconnected(id):
	print("Player " + str(id) + " Disconnected")
	
func _connected_ok():
	print("Successfully Connected To Server")
	register_player()
	rpc_id(1, "set_player_name", local_player_id, player_data)
	

func _connected_failed():
	print("Failed To Connect Server")
	
func _server_disconnected():
	print("Disconnected from server")
	
func register_player():
	local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = player_data

remote func player_joined(id, player_name):
	var chatroom = get_tree().get_root().get_node("ChatRoom")
	chatroom.player_joined(player_name)

func send_message(message):
	rpc_id(1, "send_message", local_player_id, message)

remote func receive_message(id, message):
	var chatroom = get_tree().get_root().get_node("ChatRoom")
	chatroom.receive_message(message)
