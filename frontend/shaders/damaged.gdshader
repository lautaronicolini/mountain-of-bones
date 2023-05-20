shader_type canvas_item;

uniform bool on = false;

void fragment(){
	if (on){
		COLOR = texture(TEXTURE, UV);
		COLOR.r = 0.8;
	}
}