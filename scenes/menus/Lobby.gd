extends Node

func _ready():
	pass


func _on_HostGameButton_pressed():
	ConnectionManager.on_host_game()

func _on_JoinGameButton_pressed():
	var ip = $VBoxContainer/VBoxContainer2/HBoxContainer/IPEdit.text
	print("Connecting to: " + ip)
	ConnectionManager.on_join_game(ip)
