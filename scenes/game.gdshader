// This tells Godot it's a 2D shader that will be applied to a CanvasItem.
shader_type canvas_item;

// This tells Godot to capture the screen and make it available.
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// ===================================================================
//  TWEAK THESE VALUES in the Inspector under "Shader Parameters"
// ===================================================================

// NEW: Controls the zoom level. 1.0 is no zoom.
// Increase this slightly to hide the black borders from the fisheye.
uniform float zoom : hint_range(1.0, 2.0) = 1.15;

// Controls the strength of the fisheye lens bulge.
uniform float fisheye_strength : hint_range(-1.0, 1.0) = 0.4;

// Controls how visible the dark horizontal scanlines are.
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.2;

// Controls the darkness of the corners (vignette).
uniform float vignette_intensity : hint_range(0.0, 3.0) = 1.2;


// ===================================================================
//  Shader Logic
// ===================================================================

void fragment() {
    // 1. Apply Zoom to the screen coordinates first.
    vec2 centered_uv = UV - vec2(0.5);
    vec2 zoomed_uv = centered_uv / zoom; // Divide to zoom in
    zoomed_uv += vec2(0.5);

    // 2. Apply Fisheye effect to the already zoomed coordinates.
    vec2 distorted_uv = zoomed_uv - vec2(0.5);
    float r = length(distorted_uv);
    distorted_uv = zoomed_uv + distorted_uv * (pow(r, 2.0) * fisheye_strength);
    
    // 3. Get the final color from the distorted texture.
    // The IF statement that created the black borders has been removed.
    vec4 color = texture(SCREEN_TEXTURE, distorted_uv);

    // 4. Apply other effects using the original, non-zoomed UV.
    // This keeps the scanlines and vignette perfectly aligned with the screen.
    float scanline = sin(UV.y * 800.0) * scanline_intensity;
    color.rgb -= scanline;

    float vignette = 1.0 - (length(UV - vec2(0.5)) * vignette_intensity);
    color.rgb *= vignette;

    // 5. Output the final, modified color to the screen.
    COLOR = color;
}