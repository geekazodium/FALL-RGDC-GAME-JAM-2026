shader_type spatial;
render_mode blend_premul_alpha, depth_draw_opaque, cull_disabled, unshaded, shadows_disabled;

uniform vec4 color : source_color;

uniform float time;
uniform float time_factor;

uniform sampler2D brightness;

uniform float main_texture_gamma;
uniform sampler2D main_texture : source_color, repeat_enable;

void fragment() {
	vec2 centered = UV * .75;

	float eff_time = (time - .5) * time_factor + .5;

	float emission_percent = texture(brightness, vec2(eff_time)).x;

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
