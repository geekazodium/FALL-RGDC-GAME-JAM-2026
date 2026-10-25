extends Node3D
class_name Player

@onready var animplayer : AnimationTree = $AnimationTree

var screaming : bool = false
#
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScreamCDTimer.timeout.connect(self.cooldown_over);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("scream_1"):
		#Scream1()
	#if Input.is_action_just_pressed("scream_2"):
		#Scream2()
		pass

func Scream1() -> void:
	if !screaming:
		$ScreamCDTimer.start();
		animplayer.set("parameters/OneShot/request",true);
		screaming = true
	
func Scream2() -> void:
	if !screaming:
		$ScreamCDTimer.start();
		animplayer.set("parameters/OneShot/request",true);
		screaming = true
	
func cooldown_over() -> void:
	if screaming:
		#animplayer.play("rig|run")
		screaming = false
