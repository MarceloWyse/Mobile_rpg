extends Node
@onready var battleActionButtons = $UI/BattleActionButtons
#@onready var playerStats = $PlayerStats
@onready var statsPanel = $UI/StatsPanel
@onready var healActionButton = $UI/BattleActionButtons/HealActionButton
@onready var animationPlayer = $AnimationPlayer
@onready var nextRoomButton = $UI/CenterContainer/NextRoomButton


@export var enemies: Array[PackedScene] #the .tscn is a packed scene
@onready var enemyPosition = $EnemyPosition 

var battleUnits = preload("res://MobileRPG Resources/BattleUnits.tres")
#Getting direct access to the child node so I can call down a function, to tell it to do something
#onready garantees/waits that this var will receive the node only after the scene is loaded in the game
#because when the game runs the node might not be in the scene yet
#you always put it before variables that need to get access to other nodes in the scene
#signals allow two nodes to talk to each other, or you can have a node call a function from another node
#remember the rule of thum"res://MobileRPG Resources/DefaultFont.tres"b, "call down, signal up"
#call down means if you had to talk to SwordButton you'd get a reference here 
#and call a function to send/change something in the button
#that rule can be broken, ex: if the enemy has to change sprites, we would access the sprite2d from Enemy
#and change the texture from within Enemy. We wouldn't use a signal for that 
#@onready var enemy = $Enemy
#@onready var animation = find_child("Enemy").find_child("AnimationPlayer")


func _ready():
#	enemy.connect("enemy_death", disable_button)
#	swordButton.visible = true 
#	randomize()
	start_player_turn()
	var enemy = battleUnits.Enemy
	if enemy != null:
		var callable = Callable(self, "on_enemy_died")
		enemy.enemy_death.connect(callable) #dynamic connecting lets you run connect while running the game
		#and here we will need it 'cause we will create nother enemies
		#we'll create another enemy and connect the died signal again
		#since I'll need to call self I have to make it a callable
#	battleUnits.Enemy.connect("enemy_death", on_enemy_death)
#infinite loop between player's turn and enemy's turn 	

func on_enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()
	
func start_player_turn():
	battleActionButtons.visible = true
	battleUnits.PlayerStats.ap = battleUnits.PlayerStats.max_ap
	await battleUnits.PlayerStats.player_end_turn #waits until the end turn signal has been emitted from the player
	#end_turn is emitted from player when he runs out of AP
	battleActionButtons.visible = false
	start_enemy_turn() #after the wait it starts the enemy's turn
		
func start_enemy_turn():
	if battleUnits.Enemy != null and not battleUnits.Enemy.is_queued_for_deletion():
		battleUnits.Enemy.enemy_attack() #I want to say what he can attack
		await battleUnits.Enemy.enemy_end_turn
		start_player_turn()
#
#func on_enemy_death():
#	battleActionButtons.visible = false
func create_new_enemy():
	enemies.shuffle() #shuffles the array randomly so we get different scenes when playing the game
	var enemyScene = enemies.front() #gets the scene into it 
	var enemyNode = enemyScene.instantiate() 
	enemyPosition.add_child(enemyNode)
	var callable = Callable(self, "on_enemy_died")
	battleUnits.Enemy.enemy_death.connect(callable)
	start_player_turn()
#	start_player_turn()
		
func _on_next_room_button_pressed():
	nextRoomButton.hide()
	animationPlayer.play("fade_to_new_room")
	await animationPlayer.animation_finished	
	battleActionButtons.show()
	create_new_enemy()
