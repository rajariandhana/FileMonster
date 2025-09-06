// This tells Godot it's a 2D shader that will be applied to a CanvasItem.
shader_type canvas_item;

// NEW LINE TO FIX THE ERROR IN GODOT 4
// This tells Godot to capture the screen and make it available in a variable called SCREEN_TEXTURE.
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// ===================================================================
//  TWEAK THESE VALUES in the Inspector under "Shader Parameters"
// ===================================================================

// Controls the strength of the fisheye lens bulge.
uniform float fisheye_strength : hint_range(-1.0, 1.0) = 0.4;

// Controls how visible the dark horizontal scanlines are.
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.2;

// Controls the darkness of the corners (vignette).
uniform float vignette_intensity : hint_range(0.0, 3.0) = 1.2;


// ===================================================================
//  Shader Logic (you don't need to edit below here for basic tweaks)
// ===================================================================

void fragment() {
    // Apply fisheye distortion to the screen coordinates (UV).
    vec2 distorted_uv = UV - vec2(0.5);
    float r = length(distorted_uv);
    distorted_uv = UV + distorted_uv * (pow(r, 2.0) * fisheye_strength);

    // Get the screen's color at the newly distorted coordinate.
    // This line now works because we defined SCREEN_TEXTURE at the top.
    vec4 color = texture(SCREEN_TEXTURE, distorted_uv);

    // If the distortion pulls from outside the screen, make the pixel black.
    if (distorted_uv.x < 0.0 || distorted_uv.x > 1.0 || distorted_uv.y < 0.0 || distorted_uv.y > 1.0) {
        color = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // Apply CRT Scanlines effect
        float scanline = sin(UV.y * 800.0) * scanline_intensity;
        color.rgb -= scanline;

        // Apply Vignette effect
        float vignette = 1.0 - (length(UV - vec2(0.5)) * vignette_intensity);
        color.rgb *= vignette;
    }

    // Output the final, modified color to the screen.
    COLOR = color;
}