shader_type spatial;
render_mode blend_mix, depth_draw_never, cull_back, diffuse_burley, specular_schlick_ggx;
stencil_mode write, write_depth_fail, compare_always, 1;

uniform float grow : hint_range(-16.0, 16.0, 0.001);

uniform mat4 dither = mat4(vec4(0,8,2,10),vec4(12,4,14,6),vec4(3,11,1,9),vec4(15,7,13,5));

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;

uniform float noise_scale;

void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;

	// Billboard Mode: Enabled
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			MAIN_CAM_INV_VIEW_MATRIX[0],
			MAIN_CAM_INV_VIEW_MATRIX[1],
			MAIN_CAM_INV_VIEW_MATRIX[2],
			MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);

	// Grow: Enabled
	VERTEX += NORMAL * grow;
}

void fragment() {
	vec2 base_uv = UV;
	float dither_unit_scale = 4.;
	ALPHA = 0.;
	vec2 dither_pos = fract(SCREEN_UV * VIEWPORT_SIZE/dither_unit_scale);
	//float noise = texture(dither_texture, dither_pos).x;
	float noise = dither[int(dither_pos.x * dither_unit_scale)][int(dither_pos.y * dither_unit_scale)] / 16.;
	if(length(base_uv * 2. - vec2(1,1)) > 1. - noise_scale + noise * noise_scale){
		discard;
	}
	//ALBEDO = vec3(noise);
}
