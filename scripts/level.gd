extends Node3D

@export var areaHolder:Node

@export var BPM:int = 120
@export var timeSign:int = 4
@export var area_scene:PackedScene


var bpm = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bpm = BPM / 60
	var placement = -8
	for a in range(5):
		var scene = area_scene.instantiate().get_node(".")
		scene.position.x = placement
		scene.position.y = 0
		areaHolder.add_child(scene)
		placement += 8
		print(scene.position)
	pass # Replace with function body.

var timePassed = 0;
var hit = false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = bpm * delta
	timePassed += speed
	if int(timePassed) % timeSign == 0:
		if(not hit):
			print("hit " + str(int(timePassed) / timeSign))
			hit = true
	else:
		hit = false
	
	for a in areaHolder.get_children():
		a.position.x -= speed
	
	if areaHolder.get_child(0).position.x <= -16:
		removeArea()
		spawn_new_area()

func removeArea():
	var areaToRemove = areaHolder.get_child(0)
	areaHolder.remove_child(areaToRemove)
	areaToRemove.free()
	print("removed")

func spawn_new_area():
	var scene = area_scene.instantiate().get_node(".")
	scene.position.x = 16
	scene.position.y = 0
	areaHolder.add_child(scene)
	pass

func setBPM(_bpm):
	BPM = _bpm
	bpm = BPM / 60
