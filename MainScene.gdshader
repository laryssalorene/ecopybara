shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(1, 0.75, 0.3, 1);
uniform float radius = 100.0;
uniform float flicker_intensity = 0.04;
uniform float flicker_speed = 0.5;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(UV, center);
    float attenuation = 0.8 - smoothstep(0.0, radius / 350.0, dist);

    float adjusted_time = mod(TIME * flicker_speed, 2.0 * 3.14159);
    
    float flicker = 0.65 + (sin(adjusted_time) * flicker_intensity);
    
    COLOR = light_color * attenuation * flicker;
}