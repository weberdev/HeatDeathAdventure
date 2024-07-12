shader_type canvas_item;

uniform float desaturation : hint_range(0, 1) = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    float gray = dot(color.rgb, vec3(0.3, 0.59, 0.11));
    color.rgb = mix(color.rgb, vec3(gray), desaturation);
    COLOR = color;
}
