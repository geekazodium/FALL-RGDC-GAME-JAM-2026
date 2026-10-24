@tool
extends Node2D
class_name LevelBuilder

@export var grid_size: float = 8.;
@export var bpm_unit: float = 32.;
@export_tool_button("test_generate") var test_generate = _test_generate;
func _test_generate():
	print(self.generate_level_data());

func generate_level_data() -> PackedVector2Array:
	var tempo_switch_points: Array[TempoFlag];
	tempo_switch_points.assign(self.find_children("*", "TempoFlag"));
	tempo_switch_points.sort_custom(self._comp_position_x);
	
	var current_beat: float = 0;
	var current_time: float = 0;
	var old_bps: float = 1;
	
	for p in tempo_switch_points:
		var self_beats: float = p.global_position.x / self.bpm_unit;
		var elapsed_beats: float = self_beats - current_beat;
		current_time += elapsed_beats / old_bps;
		
		p.time_seconds = current_time;
		p.time_beats = self_beats;
		print("tempo at: %s pixels, %s seconds timestamp" % [p.global_position.x, p.time_seconds]);
		
		current_beat = self_beats;
		old_bps = p.bps;
	
	var notes: Array[Note];
	notes.assign(self.find_children("*", "Note"));
	notes.sort_custom(self._comp_position_x);
	
	var current_marker_index: int;
	
	var data: PackedVector2Array = [];
	
	for p: Note in notes:
		var self_beats: float = p.global_position.x / self.bpm_unit;
		
		current_marker_index = self._try_advance_marker(self_beats, tempo_switch_points, current_marker_index);
		var current_marker: TempoFlag = tempo_switch_points[current_marker_index];
		
		var beats_diff: float = self_beats - current_marker.time_beats;
		var time_diff: float = beats_diff / current_marker.bps;
		
		var time: float = time_diff + current_marker.time_seconds;
		data.append(Vector2(1 if p.global_position.y > 0 else 2 ,time));
		print("%s" % p.global_position.x);
		
	return data;

func _try_advance_marker(beats_self: float, markers: Array[TempoFlag], index: int) -> int:
	while markers.size() > index + 1:
		if markers[index + 1].time_beats < beats_self:
			index += 1;
		else:
			break;
	return index;

func _comp_position_x(p1: Node2D, p2: Node2D) -> bool:
	return p2.global_position.x > p1.global_position.x;
