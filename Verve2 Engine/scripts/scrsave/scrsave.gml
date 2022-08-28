function save_init() {
	global.save_map = ds_map_create();
	global.save_sig = "";
	global.save_file_path = "save.sav";
	
	save_select(0);
}

function save_cleanup() {
	ds_map_destroy(global.save_map);
}
	
function save_get(_key, _default = 0) {
	_key = global.save_sig + string(_key);
	if ds_map_exists(global.save_map, _key) {
		return global.save_map[? _key];
	}
	return _default;
}

function save_set(_key, _value) {
	_key = global.save_sig + string(_key);
	global.save_map[? _key] = _value;
}
	
function save_default(_name = "") {
	if _name != "" {
		save_select(_name);
	}
	
	var _key = ds_map_find_first(global.save_map);
	while !is_undefined(_key) {
		if string_pos(global.save_sig, _key) == 1 {
			ds_map_delete(global.save_map, _key);
		}
		_key = ds_map_find_next(global.save_map, _key);
	}
	
	save_set("exists", true);
}

function save_read() {
	if file_exists(global.save_file_path) {
		var b = buffer_load(global.save_file_path);
		ds_map_read(global.save_map, buffer_read(b, buffer_text));
		buffer_delete(b);
	}
	else {
		save_default(0);
	}
}

function save_write() {
	if save_get("exists") {
		var b = buffer_create(0, buffer_grow, 1);
		buffer_write(b, buffer_text, ds_map_write(global.save_map));
		buffer_save(b, global.save_file_path);
		buffer_delete(b);
	}
}

function save_select(_name) {
	global.save_sig = "save" + string(_name);
}
