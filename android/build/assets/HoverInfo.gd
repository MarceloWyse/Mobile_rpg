extends Control

#@export_multiline var description : Array[String] 
@export var description : String
@onready var richTextLabel = get_tree().current_scene.find_child("RichTextLabel")

func _on_mouse_entered():
#	var richTextLabel = get_tree().current_scene.find_child("RichTextLabel")
	if richTextLabel != null:
		richTextLabel.text = description 

func _on_mouse_exited():
	if richTextLabel:
		richTextLabel.text = ""
