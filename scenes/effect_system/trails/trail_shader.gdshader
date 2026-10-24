shader_type spatial;
render_mode cull_disabled, ensure_correct_normals;

uniform float finite_difference_step = .01;

uniform vec4 color: source_color;

uniform vec3 start_direction;
uniform vec3 end_direction;
uniform vec3 midpoint;
uniform vec3 start_position;
uniform vec3 end_position;

vec3 lerp3(vec3 a, vec3 b, float t){
	return a + (b - a) * t;
}

vec3 sample_curve(float position) {
	return lerp3(
		lerp3(start_position, midpoint, position),
		lerp3(midpoint, end_position, position),
		position
	);
}

vec3 slerp3(vec3 a, vec3 b, float t){
	float dot_product = dot(a, b);
	if(dot_product >= .99){
		return a;
	}
	float omega = acos(dot_product);
	float sin_of_o = sin(omega);
	float a_fac = sin((1. - t) * omega) / sin_of_o;
	float b_fac = sin((t) * omega) / sin_of_o;
	return a_fac * a + b_fac * b;
}

vec3 sample_direction(float position) {
	return slerp3(start_direction, end_direction, position);
}

void vertex() {
	float curve_position = UV.y;
	vec3 position_here = sample_curve(curve_position);
	vec3 position_before = sample_curve(curve_position + finite_difference_step);
	vec3 position_delta = position_here - position_before;
	vec3 direction = normalize(sample_direction(curve_position));

	vec3 new_vertex_position = UV.x * direction + position_here;

	VERTEX = new_vertex_position;
	NORMAL = normalize(cross(direction, position_delta));
}

void fragment() {
	ALBEDO = vec3(0);
	EMISSION = color.rgb;
	ALPHA = color.a;
}
