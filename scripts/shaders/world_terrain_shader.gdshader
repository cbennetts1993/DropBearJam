shader_type canvas_item;

uniform sampler2D edge_noise;
uniform float edge_noise_weight: hint_range(0.0, 1.0, 0.1) = 0.1;
uniform sampler2D grass_texture: repeat_enable;
uniform sampler2D dirt_texture: repeat_enable;
uniform sampler2D dirt_color_ramp;

global uniform sampler2D world_terrain_noise;
varying vec2 world_UV;

void vertex() {
	world_UV = (MODEL_MATRIX*vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 size_correction = vec2(textureSize(world_terrain_noise, 0));

	vec2 terrain_uv = fract((world_UV) / size_correction);
	vec4 terrain_value = texture(world_terrain_noise, terrain_uv);
	
	vec4 dirt_color = texture(dirt_color_ramp, vec2(terrain_value.r, 0));
	vec4 grass_color = texture(grass_texture, world_UV / 64.0) * vec4(0.5, 0.8, 0.5, 1.0);
	
	vec4 color = dirt_color;
	
	if (terrain_value.r > 0.5){
		color = mix(texture(grass_texture, world_UV / 64.0), dirt_color, 0.5);
	}
	
	COLOR = color;
}

