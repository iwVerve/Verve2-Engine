function settings_init() {
	global.settings_map = ds_map_create();
	global.settings_file_path = "config.cfg";
	
	settings_read();
}

function settings_cleanup() {
	ds_map_destroy(global.settings_map);
}

function settings_get(_key, _default = 0) {
	if ds_map_exists(global.settings_map, _key) {
		return global.settings_map[? _key];
	}
	return _default;
}

function settings_set(_key, _value) {
	global.settings_map[? _key] = _value;
}
	
function settings_default() {
	settings_set("music", true);
	settings_set("volume", 0.5);
	settings_set("fullscreen", false);
}

function settings_read() {
	if file_exists(global.settings_file_path) {
		var b = buffer_load(global.settings_file_path);
		ds_map_read(global.settings_map, buffer_read(b, buffer_text));
		buffer_delete(b);
	}
	else {
		settings_default();
	}
}

function settings_write() {
	var b = buffer_create(0, buffer_grow, 1);
	buffer_write(b, buffer_text, ds_map_write(global.settings_map));
	buffer_save(b, global.settings_file_path);
	buffer_delete(b);
}
