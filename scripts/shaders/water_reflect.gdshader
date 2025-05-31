shader_type canvas_item;

uniform vec4 tint: source_color;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

uniform sampler3D wave_noise: repeat_enable;
uniform vec4 wave_tint: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec4 screen_value = texture(SCREEN_TEXTURE, UV);
	
	vec4 noise_value = texture(wave_noise, vec3(UV.x, TIME * 0.05, UV.y));
	vec4 wave_color = noise_value.x * wave_tint;
	
	vec2 uv_reflected = vec2(SCREEN_UV.x, 1.0 - SCREEN_UV.y);
	
	vec4 screen_color = texture(SCREEN_TEXTURE, uv_reflected + noise_value.x * 0.02);
	COLOR = screen_color + tint + wave_color;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
