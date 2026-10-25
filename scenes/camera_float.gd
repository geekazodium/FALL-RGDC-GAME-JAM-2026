extends Camera3D
class_name FloatingCamera

var originalPosition: Vector3;
var originalQuaternion: Quaternion;

@export var shock_force: float;
@export var restore_rate: float;
@export var idle_threashold: float;

func apply_shock(p: Vector3, q: Quaternion) -> void:
	self.quaternion *= q;
	self.position += p;

func apply_random_shock(magnitude: float) -> void:
	var shock: Vector3 = Vector3(randf(), randf(), randf()) * 2. - Vector3(1., 1., 1.);
	var shock_quaternion: Vector3 = Vector3(randf(), randf(), randf()) * 2. - Vector3(1., 1., 1.);
	self.apply_shock(shock * magnitude,Quaternion.from_euler(shock_quaternion * magnitude));

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.originalQuaternion = self.quaternion;
	self.originalPosition = self.global_position;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lerp_factor: float = 1. - exp(-delta * restore_rate);
	self.global_position = lerp(self.global_position, self.originalPosition, lerp_factor);
	self.quaternion = self.quaternion.slerp(self.originalQuaternion, lerp_factor);
	if self.originalPosition.distance_to(self.global_position) <= self.idle_threashold:
		self.apply_random_shock(self.shock_force);
