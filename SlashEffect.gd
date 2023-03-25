extends Node2D

func _on_animation_player_animation_finished(_animation):
	queue_free()
