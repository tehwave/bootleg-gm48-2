// Draw game over screen UI

// Set text properties
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

/// @type {Real}
var shadow_offset = 4;

// Draw "GAME OVER" title with shadow
draw_set_color(c_black);
draw_text_transformed(room_width / 2 + shadow_offset, room_height / 4 - 50 + shadow_offset, "GAME OVER", 3, 3, 0);
draw_set_color(c_white);
draw_text_transformed(room_width / 2, room_height / 4 - 50, "GAME OVER", 3, 3, 0);

// Draw final score with shadow
draw_set_color(c_black);
draw_text_transformed(room_width / 2 + shadow_offset, room_height / 4 + 10 + shadow_offset, "Final Score: " + string(global.score), 3, 3, 0);
draw_set_color(c_white);
draw_text_transformed(room_width / 2, room_height / 4 + 10, "Final Score: " + string(global.score), 3, 3, 0);

// Draw restart instruction (only show when can restart)
if (can_restart) {
    draw_set_color(c_black);
    draw_text_transformed(room_width / 2 + shadow_offset, room_height / 4 + 75 + shadow_offset, "Press SPACE to restart", 3, 3, 0);
    draw_set_color(c_white);
    draw_text_transformed(room_width / 2, room_height / 4 + 75, "Press SPACE to restart", 3, 3, 0);
} else {
    // Show countdown while waiting (alarm[0] / game_speed = seconds remaining)
    /// @type {Real}
    var seconds_left = ceil(alarm[0] / game_get_speed(gamespeed_fps));
    draw_set_color(c_black);
    draw_text_transformed(room_width / 2 + shadow_offset, room_height / 4 + 75 + shadow_offset, "Wait " + string(seconds_left) + "...", 3, 3, 0);
    draw_set_color(c_white);
    draw_text_transformed(room_width / 2, room_height / 4 + 75, "Wait " + string(seconds_left) + "...", 3, 3, 0);
}

// Reset text alignment and color
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
