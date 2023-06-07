shader_type canvas_item;

uniform bool on = false;

void fragment() {
	if (on) {
		vec4 original = texture(TEXTURE, UV);
		float mean = (original.x + original.y + original.z) / 3.0;
		vec4 gray = vec4(mean, mean, mean, original.a);
		COLOR = mix(original, gray, 1);
	}
}
