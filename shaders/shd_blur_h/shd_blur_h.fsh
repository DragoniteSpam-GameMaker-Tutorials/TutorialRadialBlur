varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texture_size;
uniform float blur_radius;

void main() {
    vec2 texel = 1.0 / texture_size;
    
    vec4 total_color = vec4(0);
    
    for (float i = -blur_radius; i <= blur_radius; i += 1.0) {
        total_color += texture2D(gm_BaseTexture, v_vTexcoord + vec2(i, 0) * texel);
    }
    
    total_color /= 2.0 * blur_radius + 1.0;
    
    gl_FragColor = v_vColour * total_color;
}