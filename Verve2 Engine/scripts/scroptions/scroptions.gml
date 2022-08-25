function options_init() {
	global.options_open = false;
	global.options_in_game = false;
	global.options_select = 0;
	global.options_screen = [];
	global.options_frozen_navigation = false;
	global.options_current_options = [];
	global.options_select_stack = [];
	global.options_screen_stack = [];
	global.options_close_callback = function() {};
	
	options_create_options();
}

function options_create_options() {
	
	global.options_opt_template = {
		name: "Name",
		in_game: true,
		step: function(_accept, _h_input) {
			if _accept {
				
			}
			if _h_input != 0 {
				
			}
		},
		finish: function() { },
		value: function() {
			return "Value";
		},
	}
	
	#region main options
	
	global.options_opt_music = {
		name: "Music",
		in_game: true,
		step: function(_accept, _h_input) {
			if _accept || _h_input != 0 {
				settings_set("music", !settings_get("music"));
			}
		},
		finish: undefined,
		value: function() {
			return settings_get("music") ? "On" : "Off";
		},
	}
	
	global.options_opt_volume = {
		volume_timer: 0,
		volume_delay: 10,
		
		name: "Volume",
		in_game: true,
		step: function(_accept, _h_input) {
			if _h_input != 0 {
				if volume_timer > volume_delay || volume_timer == 0 {
					settings_set("volume", clamp(settings_get("volume") + _h_input/100, 0, 1));
				}
				volume_timer++;
			}
			else {
				volume_timer = 0;
			}
		},
		finish: function() {
			volume_timer = 0;
		},
		value: function() {
			return string(floor(100 * settings_get("volume"))) + "%";
		},
	}
		
	global.options_opt_fullscreen = {
		name: "Window",
		in_game: true,
		step: function(_accept, _h_input) {
			if _accept || _h_input != 0 {
				settings_set("fullscreen", !settings_get("fullscreen"));
				window_set_fullscreen(settings_get("fullscreen"));
			}
		},
		finish: undefined,
		value: function() {
			return settings_get("fullscreen") ? "Fullscreen" : "Windowed";
		},
	}
		
	global.options_opt_keyboard = {
		name: "Keyboard settings",
		in_game: true,
		step: function(_accept, _h_input) {
			if _accept {
				options_set_screen(global.options_keyboard_options);
			}
		},
		finish: undefined,
		value: "",
	}
	
	global.options_opt_controller = {
		name: "Controller settings",
		in_game: true,
		step: function(_accept, _h_input) {
			if _accept {
				options_set_screen(global.options_controller_options);
			}
		},
		finish: undefined,
		value: "",
	}
	
	global.options_main_options = [
		global.options_opt_music,
		global.options_opt_volume,
		global.options_opt_fullscreen,
		global.options_opt_keyboard,
		global.options_opt_controller,
	];
	
	#endregion

	#region keyboard + controller options
	
	global.options_keyboard_options = [];
	global.options_controller_options = [];

	for(var c = 0; c < 2; c++) {
		var _keyboard = (c == 0);
		for(var i = 0; i < INPUT.COUNT; i++) {
			var _input = global.input_map[? i];
			if _input.rebindable {
				var _option = {
					input: i,
					keyboard: _keyboard,
					binding_key: false,
				
					name: input_get_name(i),
					in_game: true,
					step: function(_accept, _h_input) {
						if !binding_key {
							if _accept {
								binding_key = true;
							}
						}
						else {
							if keyboard {
								if keyboard_check_pressed(vk_anykey) {
									input_bind_key(input, keyboard_lastkey);
									binding_key = false;
								}
								if gamepad_button_check_any() != undefined {
									binding_key = false;
								}
							}
							else {
								var _button = gamepad_button_check_any();
								if _button != undefined {
									input_bind_button(input, _button);
									binding_key = false;
								}
								if keyboard_check_pressed(vk_anykey) {
									binding_key = false;
								}
							}
						}
						global.options_frozen_navigation = binding_key;
					},
					finish: undefined,
					value: function() {
						if !binding_key {
							if keyboard {
								return key_get_name(input_get_key(input));
							}
							else {
								return button_get_name(input_get_button(input));
							}
						}
						else {
							return "Press new " + ((keyboard) ? "key" : "button");
						}
					},
				};
				
				if (_keyboard) {
					array_push(global.options_keyboard_options, _option);
				}
				else {
					array_push(global.options_controller_options, _option);
				}
			}
		}
		
		var _reset = {
			keyboard: _keyboard,
			name: "Reset controls",
			in_game: true,
			step: function(_accept, _h_input) {
				if _accept {
					if keyboard {
						input_default_keys();
					}
					else {
						input_default_buttons();
					}
				}
			},
			finish: undefined,
			value: "",
		}
		
		if _keyboard {
			array_push(global.options_keyboard_options, _reset);
		}
		else {
			array_push(global.options_controller_options, _reset);
		}
	}
	
	#endregion

}

function options_cleanup() {
	
}

function options_open(_in_game, _callback = function () {}) {
	global.options_open = true;
	global.options_in_game = _in_game;
	global.options_close_callback = _callback;
	global.options_select = 0;
	options_set_screen(global.options_main_options);
	global.options_select_stack = [];
	global.options_screen_stack = [];
}

function options_close(_call_callback) {
	global.options_open = false;
	settings_write();
	input_write();
	if _call_callback {
		global.options_close_callback();
	}
}

function options_navigate() {
	if !global.options_open {
		exit;
	}
	
	if !global.options_frozen_navigation {
		var v = input_check_pressed(INPUT.MENU_DOWN) - input_check_pressed(INPUT.MENU_UP);
		if v != 0 {
			var _option = global.options_current_options[global.options_select];
			if is_method(_option.finish) {
				_option.finish();
			}
			global.options_select += v;
			global.options_select = mod_wrap(global.options_select, 0, array_length(global.options_current_options));
		}
		
		if input_check_pressed(INPUT.MENU_BACK) {
			options_back();
		}
	}
	
	var _option = global.options_current_options[global.options_select];
	var _h_input = input_check(INPUT.MENU_RIGHT) - input_check(INPUT.MENU_LEFT);
	if is_method(_option.step) {
		_option.step(input_check_pressed(INPUT.MENU_ACCEPT), _h_input);
	}
}
	
function options_draw() {
	if !global.options_open {
		exit;
	}
	
	var _options_count = array_length(global.options_current_options);
	
	var _x_margin = 120;
	var _y_step = 40;
	var _y_start = global.screen_height / 2 - (_options_count - 1) / 2 * _y_step;
	
	draw_set_font(fOptions);
	
	for(var i = 0; i < array_length(global.options_current_options); i++) {
		var _option = global.options_current_options[i];
		var _y = _y_start + i * _y_step;
		var _selected = (global.options_select == i);
		
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_text_outlined(_x_margin, _y, get_value(_option.name), c_white, c_black);
		draw_set_halign(fa_right);
		draw_text_outlined(global.screen_width - _x_margin, _y, get_value(_option.value), c_white, c_black);
		
		if _selected {
			draw_set_halign(fa_left);
			draw_text_outlined(_x_margin - 32, _y, ">", c_white, c_black);
			draw_set_halign(fa_right);
			draw_text_outlined(global.screen_width - _x_margin + 32, _y, "<", c_white, c_black);
		}
	}
}

function options_set_screen(_options, _dont_push_on_stack = false) {
	if !_dont_push_on_stack {
		array_push(global.options_select_stack, global.options_select);
		array_push(global.options_screen_stack, global.options_screen);
	}
		
	global.options_screen = _options;
	global.options_select = 0;
	
	global.options_current_options = [];
	for(var i = 0; i < array_length(_options); i++) {
		var _option = _options[i];
		if !global.options_in_game || !get_value(_option.in_game) {
			array_push(global.options_current_options, _option);
		}
	}
}

function options_back() {
	if array_length(global.options_screen_stack) == 0 {
		options_close(true);
	}
	else {
		options_set_screen(array_pop(global.options_screen_stack), true);
		global.options_select = array_pop(global.options_select_stack);
	}
}