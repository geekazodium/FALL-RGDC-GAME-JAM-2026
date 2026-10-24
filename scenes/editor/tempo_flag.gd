@tool
extends Sprite2D
class_name TempoFlag

const BEATS_TO_SECONDS: float = 1. / 60.; 

@export var new_tempo_bpm: float;
var bps: float:
	get:
		return new_tempo_bpm * BEATS_TO_SECONDS;
var time_seconds: float;
var time_beats: float;

static var const_tex: Texture2D = preload("res://icon.svg");

func _ready() -> void:
	self.texture = const_tex;
	self.scale.x = 0.1;
