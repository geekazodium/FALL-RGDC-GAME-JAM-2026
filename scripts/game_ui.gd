extends Control

@onready var scoreLabel:Label = $Score/ScoreText

var scoreNode
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreNode = get_tree().root.get_node("Game/Score")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreLabel.text = "Score: " + str(scoreNode.get_score())
	pass
