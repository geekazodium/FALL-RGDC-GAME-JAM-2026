extends Control

@onready var scoreLabel:Label = $Score/ScoreText
@onready var metronomeNode:Control = $Metronome/Holder
@export var metBar:PackedScene

var levelNode
var scoreNode
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelNode = get_tree().root.get_node("Game/Level")
	scoreNode = get_tree().root.get_node("Game/Score")
	pass # Replace with function body.

const metronomeSpeedUp = 75
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreLabel.text = "Score: " + str(scoreNode.get_score())
	
	for a in metronomeNode.get_children():
		a.position.x -= levelNode.speed * metronomeSpeedUp
	
	if metronomeNode.get_child_count() > 0:
		if metronomeNode.get_child(0).position.x <= 0:
			remove_bar()
			

func make_new_bar():
	const placement = 896
	var scene = metBar.instantiate()
	scene.position.x = placement
	metronomeNode.add_child(scene)
	pass

func remove_bar():
	var barToRemove = metronomeNode.get_child(0)
	metronomeNode.remove_child(barToRemove)
	barToRemove.queue_free()

func _on_level_on_beat_hit() -> void:
	make_new_bar()
	pass # Replace with function body.
