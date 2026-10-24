@tool
extends AudioStreamPlayer3D
class_name PitchedAudioStream3D

@export var min_pitch: float = .8;
@export var max_pitch: float = 1.2;

@export var start: bool:
	set(val):
		if val == true:
			self.play_sound();

func _ready() -> void:
	if !Engine.is_editor_hint():
		self.pitch_scale = randf_range(self.min_pitch, self.max_pitch);

func play_sound(start_pos: float = 0) -> void:
	self.pitch_scale = randf_range(self.min_pitch, self.max_pitch);
	super.play(start_pos);
