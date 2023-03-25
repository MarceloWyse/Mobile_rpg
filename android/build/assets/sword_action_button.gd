extends "res://ActionButton.gd"

const slashEffect = preload("res://slash_effect.tscn")
@onready var main = get_tree().current_scene

func _on_pressed():
#	var enemy = get_tree().current_scene.find_child("Enemy")
#	var playerStats = get_tree().current_scene.find_child("PlayerStats")
	if (battleUnits.Enemy and battleUnits.PlayerStats):
		create_slash(battleUnits.Enemy.global_position)
		battleUnits.Enemy.take_damage(4)
		battleUnits.PlayerStats.mp += 2 
		battleUnits.PlayerStats.ap -= 1

func create_slash(pos):
	var slashNode = slashEffect.instantiate()
	main.add_child(slashNode)
	slashNode.global_position = pos
