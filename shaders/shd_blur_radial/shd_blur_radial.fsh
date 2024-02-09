varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texture_size;
uniform float blur_radius;

void main() {
    vec2 texel = 1.0 / texture_size;
    
    vec4 total_color = vec4(0);
    float total_samples = 0.0;
    
    float samples = 32.0;
    float scale = blur_radius / sqrt(samples);
    float current_radius = 1.0;
    
    vec2 rotated_coords = vec2(scale, 0.0);
    mat2 rotation_angle = mat2(-0.7373688, -0.6754904, 0.6754904, -0.7373688);
    
    for (float i = 0.0; i < samples; i += 1.0) {
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