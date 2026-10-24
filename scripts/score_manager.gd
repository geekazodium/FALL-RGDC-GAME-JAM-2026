extends Node

var levelNode

@export var scoreGain = 10;

var score:float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelNode = get_tree().root.get_node("Game/Level")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score += scoreGain * delta
	pass

func get_score():
	return int(score)

func add_score(hit:int, mult:float):
	score += (100 * hit) * (1.5 - mult)
