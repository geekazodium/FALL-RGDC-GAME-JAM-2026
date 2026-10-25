extends Node3D

@export var BPM:int = 120
@export var timeSign:int = 4
@export var enemyPoolSize : int = 12
@export var enemyScene : String
@export var levelArray : PackedVector2Array
@export var enemySpawnTime : float = 5
@export var hitTime : float = 1
@export var secondMaterial : ShaderMaterial

@onready var player : Player = %Player

var enemies : Array[Enemy]
var enemyTotal : int
var activeEnemies : Array[Enemy]
var aliveEnemies : Array[Enemy]

var timePassed = -5

var won : bool = false

var bps = 0

@onready var levelBuilder : LevelBuilder = $LevelBuilder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("integer_division")
	bps = BPM / 60
	for i in range(enemyPoolSize):
		enemies.append(load(enemyScene).instantiate())
		add_child(enemies[i])
		enemies[i].position = Vector3(100,100,100)
		enemies[i].rotation.y = -90
	
	levelArray = levelBuilder.generate_level_data()
	levelBuilder.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timePassed += delta
	
	if(levelArray.size() > activeEnemies.size()):
		if(levelArray[activeEnemies.size()].y - timePassed < enemySpawnTime):
			var enemyIndex = enemyTotal % enemyPoolSize
			enemyTotal += 1
			activeEnemies.append(enemies[enemyIndex])
			aliveEnemies.append(enemies[enemyIndex])
			enemies[enemyIndex].position = Vector3(100,0,0)
			if(levelArray[activeEnemies.size()].x == 1):
				enemies[enemyIndex].mesh.material_override = null
			else:
				enemies[enemyIndex].mesh.material_override = secondMaterial
	
	var j : int = 0
	for useless in range(activeEnemies.size()):
		activeEnemies[j].position.x = (levelArray[j].y - timePassed) * bps
		if(activeEnemies[j].position.x <= -enemySpawnTime):
			activeEnemies[0].position = Vector3(100, 100, 100)
			activeEnemies[0].unstun()
			activeEnemies.remove_at(0)
			levelArray.remove_at(0)
		else:
			j += 1
	
	var firstAliveEnemyIndex = activeEnemies.size() - aliveEnemies.size()
	
	if(levelArray.size() - firstAliveEnemyIndex != 0):
		if(levelArray[firstAliveEnemyIndex].y > timePassed):
			if Input.is_action_just_pressed("scream_1") && levelArray[firstAliveEnemyIndex].x == 1 && levelArray[firstAliveEnemyIndex].y - timePassed < hitTime:
				enemyDied()
			if Input.is_action_just_pressed("scream_2") && levelArray[firstAliveEnemyIndex].x == 2 && levelArray[firstAliveEnemyIndex].y - timePassed < hitTime:
				enemyDied()
		else:
			gameLose()
	elif(!won):
		won = true
		gameWin()
	

func setBPM(_bpm):
	BPM = _bpm
	@warning_ignore("integer_division")
	bps = BPM / 60

func gameLose():
	print("game lost")

func gameWin():
	print("game won")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	
func enemyDied():
	aliveEnemies[0].stun()
	aliveEnemies.remove_at(0)
