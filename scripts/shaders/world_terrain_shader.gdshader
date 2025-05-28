shader_type canvas_item;

uniform sampler2D edge_noise: repeat_disable;
uniform float edge_noise_weight: hint_range(0.0, 1.0, 0.1) = 0.1;
uniform sampler2D grass_texture: repeat_enable;
uniform sampler2D dirt_texture: repeat_enable;

global uniform sampler2D world_terrain_noise;
varying vec2 world_UV;

void vertex() {
	world_UV = (MODEL_MATRIX*vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 size_correction = vec2(textureSize(world_terrain_noise, 0));
	float edge_noise_value = texture(edge_noise, world_UV/size_correction).r * edge_noise_weight;
	
	float value = texture(world_terrain_noise, (world_UV/size_correction) + edge_noise_value).r;
	
	vec4 dirt_color = texture(dirt_texture, world_UV/size_correction);
	vec4 grass_color = texture(grass_texture, world_UV/size_correction);

	vec4 color = mix(dirt_color, grass_color, value);
	COLOR = color;
}
