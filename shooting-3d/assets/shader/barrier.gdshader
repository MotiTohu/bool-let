shader_type spatial;
uniform sampler2D tex;
uniform vec3 color:source_color;
uniform float LIGHT_ST;
uniform float cont = 1.0;
uniform float diff = 0.0;

void fragment() {
	ALBEDO = color;
    vec4 a = texture(tex, UV);
	ALPHA = a.r * cont + diff;
}

void light(){
	DIFFUSE_LIGHT += LIGHT_ST;
}

