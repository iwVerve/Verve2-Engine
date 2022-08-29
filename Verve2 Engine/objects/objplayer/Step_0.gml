#region Get input
if frozen {
	player_get_no_input();
}
else if !cutscene {
	func_get_input();
}
#endregion

p_hspeed(input.h * run_speed);

if input.jump_pressed {
	func_jump();
}
if input.jump_released {
	func_release_jump();
}

p_vspeed(min(p_vspeed(), max_vspeed))

player_move_and_collide();
