function p_update_speed() {
	var _dist = point_distance(0, 0, __rel_hspeed, __rel_vspeed);
	var _angle = point_direction(0, 0, __rel_hspeed, __rel_vspeed) + __gravity_direction - 270;
	__hspeed = lengthdir_x(_dist, _angle);
	__vspeed = lengthdir_y(_dist, _angle);
}

function p_hspeed(new_value = undefined) {
	if !is_undefined(new_value) {
		__rel_hspeed = new_value;
		p_update_speed();
	}
	else return __rel_hspeed;
}

function p_vspeed(new_value = undefined) {
	if !is_undefined(new_value) {
		__rel_vspeed = new_value;
		p_update_speed();
	}
	else return __rel_vspeed;
}

function p_gravity(new_value = undefined) {
	if !is_undefined(new_value) {
		__gravity = new_value;
	}
	else return __gravity;
}

function p_gravity_direction(new_value = undefined) {
	if !is_undefined(new_value) {
		__gravity_direction = new_value;
		image_angle = __gravity_direction - 270;
		p_vspeed(0);
	}
	else return __gravity_direction;
}

function p_friction(new_value = undefined) {
	if !is_undefined(new_value) {
		__friction = new_value;
	}
	else return __friction;
}

function p_place_meeting(_x, _y, _object) {
	var _dist = point_distance(0, 0, _x - x, _y - y);
	var _dir = point_direction(0, 0, _x - x, _y - y) + __gravity_direction - 270;
	return place_meeting(x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), _object);
}

function p_place_free(_x, _y, debug = true) {
	var _dist = point_distance(0, 0, _x - x, _y - y);
	var _dir = point_direction(0, 0, _x - x, _y - y) + __gravity_direction - 270;
	
	return place_free(x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir));
}
