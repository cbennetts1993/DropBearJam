shader_type canvas_item;

uniform sampler2D wind_noise;
uniform sampler2D color_y_gradient;


void vertex() {
	// Called for every vertex the material is visible on.
	float distortion_value = texture(wind_noise, VERTEX + TIME).r;
	VERTEX += distortion_value;
}

void fragment() {
	// Called for every pixel the material is visible on.
	float y_value = 1.0 - UV.y;
	vec4 color = texture(color_y_gradient, vec2(y_value));
	COLOR *= color;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
