// Shader ported from : https://x.com/dankuntz/status/1813283813881225625
// all rights go back to him
#version 460 core
precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 u_position;
uniform vec2 u_velocity;
uniform vec2 u_resolution;
uniform sampler2D u_layerTexture;

out vec4 fragColor;
void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 p = fragCoord;
    vec2 l = u_position;

    vec2 displacement = -u_velocity * pow(clamp(1.0 - length(l - p) / 190.0, 0.0, 1.0), 2.0) * 1.5;
    vec3 color = vec3(0.0);

    for (float i = 0.0; i < 10.0; i++) {
        float s = 0.175 + 0.005 * i;
        
        // --- FIX START ---
        // 1. Calculate the normalized and displaced screen coordinate (top-down Y)
        vec2 displaced_screen_uv = (p + s * displacement) / u_resolution;
        
        // 2. Flip the Y-axis to match the texture's bottom-up orientation
        vec2 correct_texture_uv = vec2(displaced_screen_uv.x, 1.0 - displaced_screen_uv.y); 
        // --- FIX END ---
        
        color += vec3(
            texture(u_layerTexture, correct_texture_uv).r,
            
            // Repeat the fix for the other two samples (with slightly different displacement for the trail effect)
            texture(u_layerTexture, vec2(((p + (s + 0.025) * displacement) / u_resolution).x, 
                                         1.0 - ((p + (s + 0.025) * displacement) / u_resolution).y)).g,
                                         
            texture(u_layerTexture, vec2(((p + (s + 0.05) * displacement) / u_resolution).x, 
                                         1.0 - ((p + (s + 0.05) * displacement) / u_resolution).y)).b
        );
    }

    fragColor = vec4(color / 10.0, 1.0);
}