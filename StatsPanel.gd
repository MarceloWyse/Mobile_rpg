extends Panel

@onready var statsHP = $StatsContainer/HP
@onready var statsAP = $StatsContainer/AP
@onready var statsMP = $StatsContainer/MP


func _on_player_stats_hp_changed(value):
	statsHP.text = "HP\n" + str(value)


func _on_player_stats_mp_changed(value):
	statsMP.text = "MP\n" + str(value)


func _on_player_stats_ap_changed(value):
	statsAP.text = "AP\n" + str(value)
