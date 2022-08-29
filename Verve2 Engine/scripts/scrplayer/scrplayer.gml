function player_get_no_input() {
	return {
		h: 0,
		jump_pressed: false,
		jump_released: false,
		shoot: false,
		suicide: false,
	};
}

function player_get_input_default() {
	input.h = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
	input.jump_pressed = input_check_pressed(INPUT.JUMP);
	input.jump_released = input_check_released(INPUT.JUMP);
	input.shoot = input_check_pressed(INPUT.SHOOT);
	input.suicide = input_check_pressed(INPUT.SUICIDE);
}

function player_jump_default() {
	if !p_place_free(x, y+1) {
		p_vspeed(-jump_speed);
		air_jumps = max_air_jumps;
	}
	else if air_jumps > 0 {
		p_vspeed(-djump_speed);
		air_jumps--;
	}
}

function player_release_jump_default() {
	if p_vspeed() < 0 {
		p_vspeed(0.45 * p_vspeed());
	}
}

function player_land_default() {
	air_jumps = max_air_jumps;
}

function player_move_and_collide() {
	
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
}
