shader_type spatial;
render_mode unshaded;

uniform sampler2D MainTexture;
uniform vec3 Chromakey: source_color;
uniform vec3 ChromaReplace: source_color;
uniform float ChromaThreashold = -1;

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
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
