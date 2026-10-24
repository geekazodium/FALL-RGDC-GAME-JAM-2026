shader_type spatial;
render_mode blend_premul_alpha, depth_draw_opaque, cull_back, unshaded, shadows_disabled;

uniform vec4 color : source_color;

uniform float time;

uniform sampler2D time_curve;

uniform sampler2D brightness;

uniform float billboard = 1.;

uniform float main_texture_gamma;
uniform sampler2D main_texture : source_color, repeat_enable;

// billboard to camera.
void vertex() {
	mat4 identity = VIEW_MATRIX * MODEL_MATRIX;
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			MAIN_CAM_INV_VIEW_MATRIX[0],
			MAIN_CAM_INV_VIEW_MATRIX[1],
			MAIN_CAM_INV_VIEW_MATRIX[2],
			MODEL_MATRIX[3]);
	MODELVIEW_MATRIX = identity + (MODELVIEW_MATRIX - identity) * billboard;

	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec2 centered = UV * 2. - 1.;

	float eff_time = texture(time_curve,vec2(time)).x;

	float emission_percent = texture(brightness, vec2(time)).x;

	float position_brightness = (eff_time - length(centered));
	position_brightness *= position_brightness;
	position_brightness = 1./(1.+position_brightness * 100.);

	float distance_brightness = clamp(1. - length(centered),0,1);
	vec2 tex_coord = normalize(centered) * pow(length(centered), .5);
	float max_rad = pow(1.-log(1. + eff_time), 2);
	tex_coord *= max_rad;
	float albedo_tex = pow(texture(main_texture, tex_coord * .5 + .5).x, main_texture_gamma);

	ALPHA = albedo_tex * emission_percent * position_brightness * distance_brightness;
	ALBEDO = color.rgb * ALPHA;
}
