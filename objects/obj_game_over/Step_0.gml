// Check for space key to restart (only after delay)
if (can_restart && keyboard_check_pressed(vk_space)) {
    global.score = 0;  // Reset score for new game
    room_goto(rm_main);
}
