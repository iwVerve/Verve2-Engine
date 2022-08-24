enum INPUT {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	JUMP,
	SHOOT,
	RESTART,
	SKIP,
	SUICIDE,
	PAUSE,
	ALIGN_LEFT,
	ALIGN_RIGHT,
	MENU_LEFT,
	MENU_RIGHT,
	MENU_UP,
	MENU_DOWN,
	MENU_ACCEPT,
	MENU_BACK,
	MENU_OPTIONS,
	
	COUNT,
}

function input_init() {
	global.input_controller_mode = false;
	global.input_controller_index = 0;
	global.input_file_path = "binds.ini";
	
	global.input_map = ds_map_create();
	global.input_map[? INPUT.LEFT]    = new input_definition("Left",    vk_left,  gp_padl,   true);
	global.input_map[? INPUT.RIGHT]   = new input_definition("Right",   vk_right, gp_padr,   true);
	global.input_map[? INPUT.UP]      = new input_definition("Up",      vk_up,    gp_padu,   true);
	global.input_map[? INPUT.DOWN]    = new input_definition("Down",    vk_down,  gp_padd,   true);
	global.input_map[? INPUT.JUMP]    = new input_definition("Jump",    vk_shift, gp_face1,  true);
	global.input_map[? INPUT.SHOOT]   = new input_definition("Shoot",   ord("Z"), gp_face3,  true);
	global.input_map[? INPUT.RESTART] = new input_definition("Restart", ord("R"), gp_face4,  true);
	global.input_map[? INPUT.SKIP]    = new input_definition("Skip",    ord("S"), gp_face2,  true);
	global.input_map[? INPUT.SUICIDE] = new input_definition("Suicide", ord("Q"), gp_select, true);
	global.input_map[? INPUT.PAUSE]   = new input_definition("Pause",   ord("P"), gp_start,  true);
	
	global.input_map[? INPUT.ALIGN_LEFT]   = new input_definition("A/D Left",     ord("A"), gp_shoulderl, false);
	global.input_map[? INPUT.ALIGN_RIGHT]  = new input_definition("A/D Right",    ord("D"), gp_shoulderr, false);
	global.input_map[? INPUT.MENU_LEFT]    = new input_definition("Menu Left",    vk_left,  gp_padl,      false);
	global.input_map[? INPUT.MENU_RIGHT]   = new input_definition("Menu Right",   vk_right, gp_padr,      false);
	global.input_map[? INPUT.MENU_UP]      = new input_definition("Menu Up",      vk_up,    gp_padu,      false);
	global.input_map[? INPUT.MENU_DOWN]    = new input_definition("Menu Down",    vk_down,  gp_padd,      false);
	global.input_map[? INPUT.MENU_ACCEPT]  = new input_definition("Menu Accept",  vk_shift, gp_face1,     false);
	global.input_map[? INPUT.MENU_BACK]    = new input_definition("Menu Back",    ord("Z"), gp_face2,     false);
	global.input_map[? INPUT.MENU_OPTIONS] = new input_definition("Menu Options", vk_enter, gp_select,    false);
	
	input_read();
}

function input_cleanup() {
	ds_map_destroy(global.input_map);
}

function input_write() {
	ini_open(global.input_file_path);
	for(var i = 0; i < INPUT.COUNT; i++) {
		var _bind = global.input_map[? i];
		if _bind.rebindable {
			ini_write_real("Keyboard", _bind.name, _bind.key);
			ini_write_real("Controller", _bind.name, _bind.button);
		}
	}
	ini_close();
}

function input_read() {
	ini_open(global.input_file_path);
	for(var i = 0; i < INPUT.COUNT; i++) {
		var _bind = global.input_map[? i];
		if _bind.rebindable {
			_bind.key = ini_read_real("Keyboard", _bind.name, _bind.default_key);
			_bind.button = ini_read_real("Controller", _bind.name, _bind.default_button);
		}
	}
	ini_close();
}

function input_definition(_name, _default_key, _default_button, _rebindable) constructor {
	name = _name;
	key = _default_key;
	button = _default_button;
	default_key = _default_key;
	default_button = _default_button;
	rebindable = _rebindable;
}
	
function input_check(_input) {
	if global.input_controller_mode {
		return gamepad_button_check(global.input_controller_index, global.input_map[? _input].button);
	}
	else {
		return keyboard_check(global.input_map[? _input].key);
	}
}
	
function input_check_pressed(_input) {
	if global.input_controller_mode {
		return gamepad_button_check_pressed(global.input_controller_index, global.input_map[? _input].button);
	}
	else {
		return keyboard_check_pressed(global.input_map[? _input].key);
	}
}

function input_check_released(_input) {
	if global.input_controller_mode {
		return gamepad_button_check_released(global.input_controller_index, global.input_map[? _input].button);
	}
	else {
		return keyboard_check_released(global.input_map[? _input].key);
	}
}

function input_bind_key(_input, _key) {
	global.input_map[? _input].key = _key;
}

function input_bind_button(_input, _button) {
	global.input_map[? _input].button = _button;
}

function input_default_keys() {
	for(var i = 0; i < INPUT.COUNT; i++) {
		global.input_map[? i].key = global.input_map[? i].default_key;
	}
}

function input_default_buttons() {
	for(var i = 0; i < INPUT.COUNT; i++) {
		global.input_map[? i].button = global.input_map[? i].default_button;
	}
}
