function p_update_speed() {
	var _dist = point_distance(0, 0, __rel_hspeed, __rel_vspeed);
	var _angle = point_direction(0, 0, __rel_hspeed, __rel_vspeed) + __gravity_direction - 270;
	__hspeed = lengthdir_x(_dist, _angle);
	__vspeed = lengthdir_y(_dist, _angle);
}

function p_hspeed(_new_value = undefined) {
	if !is_undefined(_new_value) {
		__rel_hspeed = _new_value;
		p_update_speed();
	}
	else {
		return __rel_hspeed;
	}
}

function p_vspeed(_new_value = undefined) {
	if !is_undefined(_new_value) {
		__rel_vspeed = _new_value;
		p_update_speed();
	}
	else {
		return __rel_vspeed;
	}
}

function p_gravity(_new_value = undefined) {
	if !is_undefined(_new_value) {
		__gravity = _new_value;
	}
	else {
		return __gravity;
	}
}

function p_gravity_direction(_new_value = undefined) {
	if !is_undefined(_new_value) {
		__gravity_direction = _new_value;
		image_angle = __gravity_direction - 270;
		p_vspeed(0);
	}
	else {
		return __gravity_direction;
	}
}

function p_friction(_new_value = undefined) {
	if !is_undefined(_new_value) {
		__friction = _new_value;
	}
	else {
		return __friction;
	}
}

function p_speed(_new_value = undefined) {
	if !is_undefined(_new_value) {
		var _direction = p_direction();
		__hspeed = lengthdir_x(_new_value, _direction);
		__vspeed = lengthdir_y(_new_value, _direction);
	}
	else {
		return point_distance(0, 0, __hspeed, __vspeed);
	}
}

function p_direction(_new_value = undefined) {
	if !is_undefined(_new_value) {
		var _speed = p_speed();
		__hspeed = lengthdir_x(_speed, _new_value);
		__vspeed = lengthdir_y(_speed, _new_value);
	}
	else {
		return point_direction(0, 0, __hspeed, __vspeed);
	}
}

function p_place_meeting(_x, _y, _object) {
	var _dist = point_distance(0, 0, _x - x, _y - y);
	var _dir = point_direction(0, 0, _x - x, _y - y) + __gravity_direction - 270;
	return place_meeting(x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), _object);
}

function p_place_free(_x, _y) {
	var _dist = point_distance(0, 0, _x - x, _y - y);
	var _dir = point_direction(0, 0, _x - x, _y - y) + __gravity_direction - 270;
	
	return place_free(x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir));
}
