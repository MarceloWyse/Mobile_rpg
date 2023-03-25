extends "res://ActionButton.gd"

#@onready var playerStats = get_tree().current_scene.find_child("PlayerStats")
#var playerStats = battleUnits.PlayerStats

func _on_pressed():
	if battleUnits.PlayerStats.mp >= 8:
		battleUnits.PlayerStats.ap -= 2
		battleUnits.PlayerStats.mp -= 8
		battleUnits.PlayerStats.hp += randi_range(1,5)
