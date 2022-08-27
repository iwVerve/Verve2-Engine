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
