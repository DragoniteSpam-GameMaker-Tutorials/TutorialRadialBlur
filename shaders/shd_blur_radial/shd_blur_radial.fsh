varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texture_size;
uniform float blur_radius;

void main() {
    vec2 texel = 1.0 / texture_size;
    
    vec4 total_color = vec4(0);
    
    float samples = 32.0;
    float scale = blur_radius / sqrt(samples);
    float current_radius = 1.0;
    
    for (float i = 0.0; i < 6.28; i += 6.28 / samples) {
        current_radius += 1.0 / current_radius;
        
        vec2 sample_coords = v_vTexcoord + vec2(
            cos(i),
            -sin(i)
        ) * texel * scale * (current_radius - 1.0);
        
        total_color += texture2D(gm_BaseTexture, sample_coords);
    }
    
    total_color /= samples;
    
    
    
    gl_FragColor = v_vColour * total_color;
}