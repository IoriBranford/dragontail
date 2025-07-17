varying vec4 vertexColor;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 texturecolor = Texel(tex, texture_coords);
    if (texturecolor.a < 0.5)
        discard;
    return texturecolor * vertexColor * color;
}