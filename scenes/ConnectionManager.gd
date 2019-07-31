extends Node

const PORT = 12234
const MAX_PLAYERS = 4

var ship
var players = []

func _ready():
	ship = preload("res://scenes/player/Ship.tscn")
	get_tree().connect("connected_to_server", self, "_connected_ok")

func _connected_ok():
	rpc("register_player", get_tree().get_network_unique_id())
	register_player(get_tree().get_network_unique_id())
	get_tree().get_root().get_node("Lobby").queue_free()

remote func register_player(player_id):
	var ship_instance = ship.instance()
	
	ship_instance.set_network_master(player_id)
	ship_instance.name = str(player_id)
	get_tree().get_root().add_child(ship_instance)
	
	if get_tree().get_network_unique_id() == 1:
		if player_id != 1:
			for player in players:
				rpc_id(player_id, "register_player", player)
		players.append(player_id)

func on_host_game():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, MAX_PLAYERS)
	print("----")
	print(IP.get_local_addresses())
	print("----")
	get_tree().set_network_peer(host)
	
	_connected_ok()

func on_join_game(ip):
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, PORT)
	get_tree().set_network_peer(host)



