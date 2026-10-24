extends Node3D

@onready var screamArea:Area3D = $Scream

@export var screamTime = 1
var screamTimer = 0

var is_screaming = false

var enemies_in_area:Array[Node3D]

var levelNode
var scoreNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelNode = get_tree().root.get_node("Game/Level")
	scoreNode = get_tree().root.get_node("Game/Score")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scream") and not is_screaming:
		screamTimer = screamTime
		pass

	if screamTimer > 0:
		is_screaming = true
		screamTimer -= delta
	else:
		is_screaming = false
	screamArea.visible = is_screaming
	
	scream()

func _on_scream_body_entered(body: Node3D) -> void:
	enemies_in_area.append(body)

func _on_scream_body_exited(body: Node3D) -> void:
	enemies_in_area.remove_at(enemies_in_area.find(body))

func enemy_is_stunned(enemy):
	return not enemy.isStunned

func scream():
	if is_screaming:
		if enemies_in_area.filter(enemy_is_stunned).size() > 0:
			var timing = levelNode.timePassed
			scoreNode.add_score(enemies_in_area.filter(enemy_is_stunned).size(), abs(timing - round(levelNode.timePassed)))
		for enemy in enemies_in_area:
			enemy.stun()
