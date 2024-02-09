varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texture_size;
uniform float blur_radius;
uniform float sample_count;

vec2 random(vec2 value) {
    vec4 coefficients = vec4(0.861340446, 0.3840795681, 0.861340446, 0.3840795681);
	return normalize(vec2(
        fract(cos(dot(value, coefficients.xy)) * 9517.1063),
        fract(cos(dot(value, coefficients.zw)) * 4375.5453)
    ) - 0.5);
}

void main() {
    vec2 texel = 1.0 / texture_size;
    
    vec4 total_color = vec4(0);
    float total_samples = 0.0;
    
    float scale = blur_radius / sqrt(sample_count);
    float current_radius = 1.0;
    
    vec2 rotated_coords = random(v_vTexcoord) * scale;
    mat2 rotation_angle = mat2(-0.7373688, -0.6754904, 0.6754904, -0.7373688);
    
    for (float i = 0.0; i < sample_count; i += 1.0) {
        current_radius += 1.0 / current_radius;
        rotated_coords *= rotation_angle;
        
        vec2 sample_coords = v_vTexcoord + rotated_coords * texel * (current_radius - 1.0);
        
        float sample_weight = 1.0 / current_radius;
        total_samples += sample_weight;
        
        total_color += texture2D(gm_BaseTexture, sample_coords) * sample_weight;
    }
    
    total_color /= total_samples;
    
    
    
    gl_FragColor = v_vColour * total_color;
}