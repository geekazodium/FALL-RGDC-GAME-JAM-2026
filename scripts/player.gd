extends Node3D
class_name Player

@onready var animplayer : AnimationPlayer = $AnimationPlayer

var screaming : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animplayer.animation_finished.connect(Run)
	animplayer.play("rig|run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scream_1"):
		Scream1()
	if Input.is_action_just_pressed("scream_2"):
		Scream2()

func Scream1() -> void:
	if !screaming:
		animplayer.play("rig|YELL")
		screaming = true
	
func Scream2() -> void:
	if !screaming:
		animplayer.play("rig|YELL")
		screaming = true
	
func Run(name : StringName) -> void:
	print("run called")
	if screaming:
		animplayer.play("rig|run")
		screaming = false
