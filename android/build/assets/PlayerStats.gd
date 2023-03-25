extends Node

var battleUnits = preload("res://MobileRPG Resources/BattleUnits.tres")
#access to the resource within player

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)
signal player_end_turn
#use signals to talk between siblings in a tree

var max_hp = 25

var hp = max_hp:
	set(value):
#		hp = min(value, max_hp)
	#min() chooses the smallest of the two possibilities, that guarantees that the hp won't pass 
	#the value we set for max_hp
		#on the other hand, clamp gives a min value and a max value, so it never goes below the min value
		#which is what we want, we don't want hp to drop below 0...
		#so it's like an if, but with less code
		hp = clampi(value, 0, max_hp)
		emit_signal("hp_changed", hp) 

var max_ap = 3

var ap = max_ap:
	set(value):
		ap = clamp(value, 0, max_ap)
		emit_signal("ap_changed", ap)
		if ap == 0:
			emit_signal("player_end_turn")
					
var max_mp = 10

var mp = max_mp:
	set(value):
		mp = clamp(value, 0, max_mp)
		emit_signal("mp_changed", mp)

#gives access to resources to this script, so you can use PlayerStats by referecing Player
#without having to use the get_tree(), etc... it's more organized than creating a bunch of connections
func _ready():
	battleUnits.PlayerStats = self

func _exit_tree():
	battleUnits.PlayerStats = null
