if frozen {
	player_get_no_input();
}
else if !cutscene {
	func_get_input();
}

p_hspeed(input.h * run_speed);

if input.jump_pressed {
	func_jump();
}
if input.jump_released {
	func_release_jump();
}

p_vspeed(min(p_vspeed(), max_vspeed))

p_vspeed(p_vspeed() + __gravity);

if !p_place_free(x + p_hspeed(), y + p_vspeed()) {
	if abs(p_hspeed()) > 0 && !p_place_free(x + p_hspeed(), y) {
		var _dist = abs(p_hspeed());
		var _dir = __gravity_direction + ((p_hspeed() > 0) ? 90 : 270);
		move_contact_solid(_dir, _dist);
		p_hspeed(0);
	}
	if abs(p_vspeed()) > 0 && !p_place_free(x, y + p_vspeed()) {
		var _dist = abs(p_vspeed());
		var _dir = __gravity_direction + ((p_vspeed() > 0) ? 0 : 180);
		move_contact_solid(_dir, _dist);
		if p_vspeed() > 0 {
			func_land();
		}
		p_vspeed(0);
	}
	if !p_place_free(x + p_hspeed(), y + p_vspeed()) {
		p_hspeed(0);
	}
}

x += __hspeed;
y += __vspeed;
