extends Node3D

@export var areaHolder:Node

@export var BPM:int = 120
@export var timeSign:int = 4
@export var levelArray : PackedVector2Array
@export var hitTime : float = 1
@export var enemyScene : String
@export var enemyPoolSize : int = 6
@export var enemySpawnTime : float = 10

var enemies : Array[Enemy]
var enemyTotal : int
var activeEnemies : Array[Enemy]

@export var screamsfx_1 : AudioStream
@export var screamsfx_2 : AudioStream

var timePassed = 0

var bps = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bps = BPM / 60
	for i in range(enemyPoolSize):
		enemies.append(load(enemyScene).instantiate())
		add_child(enemies[i])
		enemies[i].position = Vector3(100,100,100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timePassed += delta
	
	if(levelArray.size() > activeEnemies.size()):
		if(levelArray[activeEnemies.size()].y - timePassed < enemySpawnTime):
			var enemyIndex = enemyTotal % enemyPoolSize
			enemyTotal += 1
			activeEnemies.append(enemies[enemyIndex])
			enemies[enemyIndex].position = Vector3(100,0,0)
	
	for i in range(activeEnemies.size()):
		activeEnemies[i].position.x = (levelArray[i].y - timePassed) * bps
	
	if(levelArray[0].y > timePassed):
		if Input.is_action_just_pressed("scream_1") && levelArray[0].x == 1 && levelArray[0].y - timePassed < hitTime:
			print("timing hit")
			enemyDied()
		if Input.is_action_just_pressed("scream_2") && levelArray[0].x == 2 && levelArray[0].y - timePassed < hitTime:
			print("timing hit")
			enemyDied()
	else:
		gameLose()
		
	if(levelArray.size() == 0):
		gameWin()

func setBPM(_bps):
	BPM = _bps
	bps = BPM / 60

func gameLose():
	print("game lost")

func gameWin():
	print("game won")
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	
func enemyDied():
	levelArray.remove_at(0)
	activeEnemies[0].position = Vector3(100, 100, 100)
	activeEnemies.remove_at(0)
