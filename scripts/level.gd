extends Node3D

@export var areaHolder:Node

@export var BPM:int = 120
@export var timeSign:int = 4
@export var area_scene:Array[PackedScene]

var bpm = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    bpm = BPM / 60
    var placement = -8
    for a in range(5):
        var rand = randi() % area_scene.size()
        var scene = area_scene.get(rand).instantiate()
        scene.position = Vector3(placement, 0, 0)
        areaHolder.add_child(scene)
        placement += 8
    pass # Replace with function body.

var timePassed = 0;
var speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    speed = bpm * delta
    timePassed += speed
    #print("hit " + str((int(timePassed) / timeSign) + 1) + " : " + str((int(timePassed) % timeSign + 1)))
    
    for a in areaHolder.get_children():
        a.position.x -= speed
    
    if areaHolder.get_child_count() > 0:
        if areaHolder.get_child(0).position.x <= -16:
            removeArea()
            spawn_new_area()

func removeArea():
    var areaToRemove = areaHolder.get_child(0)
    areaHolder.remove_child(areaToRemove)
    areaToRemove.queue_free()

func spawn_new_area():
    var rand = randi() % area_scene.size()
    var scene = area_scene.get(rand).instantiate()
    scene.position = Vector3(16, 0, 0)
    areaHolder.add_child(scene)
    pass

func setBPM(_bpm):
    BPM = _bpm
    bpm = BPM / 60
