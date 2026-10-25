shader_type spatial;

uniform sampler2D MainTexture;
uniform vec3 Chromakey: source_color;
uniform vec3 ChromaReplace: source_color;
uniform float ChromaThreashold = -1;
uniform float lightStep = 0;
uniform float runSpeed = .3;
uniform vec3 offset_dir;
uniform float albedo_brightness = .5;

void vertex() {
	float offset = fract(TIME * runSpeed);
	VERTEX += offset * offset_dir;
}

void fragment() {
	ALBEDO = texture(MainTexture, UV).xyz;
	float blend = (dot(normalize(ALBEDO*2. - 1.), normalize(Chromakey * 2. - 1.)) - ChromaThreashold);
	blend /= 1. - ChromaThreashold;
	if(ChromaThreashold < 0.){
		blend = 0.;
	}
	ALBEDO = ALBEDO + (ChromaReplace - ALBEDO) * clamp(blend, 0, 1);
}

void light() {
    if (LIGHT_IS_AREA) {
    } else {
        DIFFUSE_LIGHT = albedo_brightness * clamp(dot(NORMAL, LIGHT) * ATTENUATION, 0 , 1) * LIGHT_COLOR / PI;
    }
}
