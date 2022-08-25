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

function key_get_name(_key) {
	switch(_key) {
		case vk_space: return "Space";
	    case vk_shift: return "Shift";
	    case vk_control: return "Control";
	    case vk_alt: return "Alt";
	    case vk_enter: return "Enter";
	    case vk_up: return "Up";
	    case vk_down: return "Down";
	    case vk_left: return "Left";
	    case vk_right: return "Right";
	    case vk_backspace: return "Backspace";
	    case vk_tab: return "Tab";
	    case vk_insert: return "Insert";
	    case vk_delete: return "Delete";
	    case vk_pageup: return "Page Up";
	    case vk_pagedown: return "Page Down";
	    case vk_home: return "Home";
	    case vk_end: return "End";
	    case vk_escape: return "Escape";
	    case vk_printscreen: return "Print Screen";
	    case vk_f1: return "F1";
	    case vk_f2: return "F2";
	    case vk_f3: return "F3";
	    case vk_f4: return "F4";
	    case vk_f5: return "F5";
	    case vk_f6: return "F6";
	    case vk_f7: return "F7";
	    case vk_f8: return "F8";
	    case vk_f9: return "F9";
	    case vk_f10: return "F10";
	    case vk_f11: return "F11";
	    case vk_f12: return "F12";
	    case vk_lshift: return "Left Shift";
	    case vk_rshift: return "Right Shift";
	    case vk_lcontrol: return "Left Control";
	    case vk_rcontrol: return "Right Control";
	    case vk_lalt: return "Left Alt";
	    case vk_ralt: return "Right Alt";
	    //numpad keys
	    case 96: return "0";
	    case 97: return "1";
	    case 98: return "2";
	    case 99: return "3";
	    case 100: return "4";
	    case 101: return "5";
	    case 102: return "6";
	    case 103: return "7";
	    case 104: return "8";
	    case 105: return "9";
	    case 106: return "*";
	    case 107: return "+";
	    case 109: return "-";
	    case 110: return ".";
	    case 111: return "/";
	    //misc keys
	    case 186: return ";";
	    case 187: return "=";
	    case 188: return ",";
	    case 189: return "-";
	    case 190: return ".";
	    case 191: return "/";
	    case 192: return "`";
	    case 219: return "[";
	    case 220: return "\\";
	    case 221: return "]";
	    case 222: return "'";
	    //other characters
	    default: return chr(_key);
	}
}

function button_get_name(_button) {
	switch (_button)
	{
	    case gp_face1: return "A/Cross"; break;
	    case gp_face2: return "B/Circle"; break;
	    case gp_face3: return "X/Square"; break;
	    case gp_face4: return "Y/Triangle"; break;
	    case gp_shoulderl: return "Left Bumper"; break;
	    case gp_shoulderlb: return "Left Trigger"; break;
	    case gp_shoulderr: return "Right Bumper"; break;
	    case gp_shoulderrb: return "Right Trigger"; break;
	    case gp_select: return "Select/Touch-Pad"; break;
	    case gp_start: return "Start/Options"; break;
	    case gp_stickl: return "Left Stick (pressed)"; break;
	    case gp_stickr: return "Right Stick (pressed)"; break;
	    case gp_padu: return "D-Pad Up"; break;
	    case gp_padd: return "D-Pad Down"; break;
	    case gp_padl: return "D-Pad Left"; break;
	    case gp_padr: return "D-Pad Right"; break;
	    default: return "Unknown"; break;
	}
}

function gamepad_button_check_any() {
	var _buttons = [
		gp_face1,
		gp_face2,
		gp_face3,
		gp_face4,
		gp_padl,
		gp_padr,
		gp_padu,
		gp_padd,
		gp_stickl,
		gp_stickr,
		gp_select,
		gp_start,
		gp_shoulderl,
		gp_shoulderlb,
		gp_shoulderr,
		gp_shoulderrb,
	];
	
	for(var i = 0; i < array_length(_buttons); i++) {
		var _button = _buttons[i];
		if gamepad_button_check(global.input_controller_index, _button) {
			return _button;
		}
	}
	
	return undefined;
}

function get_value(_val_or_func) {
	if is_method(_val_or_func) {
		return _val_or_func();
	}
	return _val_or_func;
}
