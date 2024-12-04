shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(1.0, 0.9, 0.65, 0.8);
uniform float radius = 100.0;
uniform float flicker_intensity = 1.0;
uniform float flicker_speed = 0.5;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(UV, center);
    float attenuation = 1.0 - smoothstep(0.3, 200.0 / 350.0, dist);

    float adjusted_time = mod(TIME * flicker_speed, 2.0 * 3.14159);

    float flicker = 1.0 + (sin(adjusted_time) * 0.2);

    COLOR = vec4(1.0, 0.9, 0.75, 0.4) * attenuation * flicker;
}