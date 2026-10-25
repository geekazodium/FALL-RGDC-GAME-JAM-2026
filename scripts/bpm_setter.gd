extends Control

var levelNode

@onready var bpmButton = $"Button"
@onready var bpmSlider = $"HSlider"
@onready var bpmLabel = $'Label'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#levelNode = get_tree().root.get_node("Game/Level")
	bpmButton.pressed.connect(setBPM)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bpmLabel.text = str(int(bpmSlider.value));
	pass

func setBPM() -> void:
	print("BPM set to :" + str(int(bpmSlider.value)))
	levelNode.setBPM(int(bpmSlider.value))
	pass
