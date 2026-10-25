extends Control

@onready var scoreLabel:Label = $Score/ScoreText
#
#var levelNode
#var scoreNode
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#levelNode = get_tree().root.get_node("Game/Level")
	#scoreNode = get_tree().root.get_node("Game/Score")
	#pass # Replace with function body.
#
#const metronomeSpeedUp = 75
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#scoreLabel.text = "Score: " + str(scoreNode.get_score())
