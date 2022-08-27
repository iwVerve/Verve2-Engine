#region Physics constants
run_speed_default = 3;
jump_speed_default = 8.5;
djump_speed_default = 7;
max_vspeed = 9;
gravity_default = 0.4;
max_air_jumps = 1;
#endregion

#region Movement variables
__hspeed = 0;
__vspeed = 0;
__rel_hspeed = 0;
__rel_vspeed = 0;
__gravity = 0;
__gravity_direction = 270;
__friction = 0;
#endregion

frozen = false;
cutscene = false;
input = {
	h: 0,
	jump_pressed: false,
	jump_released: false,
	shoot: false,
	suicide: false,
}

run_speed = run_speed_default;
jump_speed = jump_speed_default;
djump_speed = djump_speed_default;
air_jumps = max_air_jumps;
__gravity = gravity_default;

func_get_input = player_get_input_default;
func_jump = player_jump_default;
func_release_jump = player_release_jump_default;
func_land = player_land_default;

p_gravity_direction(315);