function mod_wrap(_val, _min, _max) {
	var f = _val - _min;
	var w = _max - _min;
	return f - floor(f/w) * w + _min;
}

function in_range(_val, _min, _max) {
	return _val >= _min && _val <= _max;
}

function draw_text_outlined(_x, _y, _string, _c_text, _c_outline, _thickness = 1, _precision = 8) {
	draw_set_color(_c_outline);
	for(var i = 0; i < _precision; i++) {
		var _angle = i/_precision * 360;
		draw_text(_x + lengthdir_x(_thickness, _angle), _y + lengthdir_y(_thickness, _angle), _string);
	}
	draw_set_color(_c_text);
	draw_text(_x, _y, _string);
}

function print() {
	var _out = ""
	for(var i = 0; i < argument_count; i++) {
		_out += string(argument[i]);
		if i < argument_count - 1 {
			_out += " ";
		}
	}
	show_debug_message(_out);
}