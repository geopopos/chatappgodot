extends Node

var network = NetworkedMultiplayerENet.new()
var port = 3234
var max_players = 4

var players = {}

func _ready():
	start_server()
	
func start_server():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	network.connect("peer_connected", self, "_player_connected")
	network.connect("peer_disconnected", self, "_player_disconnected")
	
	print("server started")

func _player_connected(player_id):
	print("Player " + str(player_id) + " Connected")

func _player_disconnected(player_id):
	print("Player " + str(player_id) + " Disconnected")
	
remote func set_player_name(id, player_data):
	players[id] = player_data
	print(players)
	rpc("player_joined", id, player_data["player_name"])
	
remote func send_message(id, message):
	var player_name = players[id]["player_name"]
	var text = player_name + ": " + message
	rpc("receive_message", id, text)
