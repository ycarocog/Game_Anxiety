shader_type canvas_item;
render_mode unshaded;

uniform bool change = true;

void fragment() {
	if (change){
		COLOR = texture(TEXTURE, UV);
		float lumi = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR.rgb = vec3(lumi);
	}

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
