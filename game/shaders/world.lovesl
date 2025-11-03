// How much to apply texture RGB
// 1 = normal; 0 = solid silhouette
uniform float texRgbFactor = 1.0;

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{
    vec4 texcolor = Texel(tex, texture_coords);
    texcolor.rgb = mix(vec3(1.0, 1.0, 1.0), texcolor.rgb, texRgbFactor);
    return texcolor * color;
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}