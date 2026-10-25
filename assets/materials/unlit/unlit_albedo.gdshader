shader_type spatial;

uniform sampler2D MainTexture;
uniform vec3 Chromakey: source_color;
uniform vec3 ChromaReplace: source_color;
uniform float ChromaThreashold = -1;
uniform float lightStep = 0.2;

uniform float albedo_brightness = .5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = texture(MainTexture, UV).xyz;
	float blend = (dot(normalize(ALBEDO*2. - 1.), normalize(Chromakey * 2. - 1.)) - ChromaThreashold);
	blend /= 1. - ChromaThreashold;
	if(ChromaThreashold < 0.){
		blend = 0.;
	}
	ALBEDO = ALBEDO + (ChromaReplace - ALBEDO) * clamp(blend, 0, 1);
	//AO = 0.;
}

void light() {
    if (LIGHT_IS_AREA) {
    } else {
        DIFFUSE_LIGHT = albedo_brightness * step(lightStep, dot(NORMAL, LIGHT) * ATTENUATION) * LIGHT_COLOR / PI;
    }
}
