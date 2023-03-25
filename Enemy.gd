extends Node2D

@onready var hpLabel = $HPLabel
@onready var animationPlayer = $AnimationPlayer
var battleUnits = preload("res://MobileRPG Resources/BattleUnits.tres")

signal enemy_death
signal enemy_end_turn
#var target = null
@export var damage : int
#@export var attack = 10

@export var hp : int:
	set(value):
		hp = value
		if hpLabel != null: #the problem was it was being set before being created
			hpLabel.text = str(value)
#		set_deferred("hp", value)
		#good way to update the UI with a setter
#		set_deferred("hpLabel.text", str(hp))
#		set_deferred("hp", value)
#		set_label(value)
#		call_deferred("set_label", value)

#			if hp <= 0:
#			emit_signal("enemy_death")
#			queue_free()
						
#		else:
#			animationPlayer.play("shake")
#			await animationPlayer.animation_finished					
#			animationPlayer.play("attack")
##			await animationPlayer.animation_finished
#			#weird way to communicate between nodes... by getting it from it's parent
#			var world = get_tree().current_scene
#			var player = world.find_child("PlayerStats")
#			player.hp -= 3

#func set_label(value):
#	hpLabel.text = str(value)

func enemy_attack() -> void: #this specifies the return, it's optional, you can do a normal function instead
	#we set up a await after the shake
	await get_tree().create_timer(0.4).timeout #you havet to call the timer from the scene, timeout is the signal
	animationPlayer.play("attack")
#	self.target = target #gets this reference target into my var target created in the beginning
	#gotta use self. to specify, since there are two different variables with the same name 
	await animationPlayer.animation_finished
#	target.hp -= 3
#	self.target = null
	emit_signal("enemy_end_turn")

func take_damage(amount):
	hp -= amount
	if enemy_is_dead():
		emit_signal("enemy_death")
		queue_free()
	else:
		animationPlayer.play("shake")

func deal_damage_mid_animation():		
#	target.hp -= 4
	battleUnits.PlayerStats.hp -= damage
		
func enemy_is_dead():
	return hp <= 0
	
func _ready():
	battleUnits.Enemy = self	

func _exit_tree():
	battleUnits.Enemy = null
