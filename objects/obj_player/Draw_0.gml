// Draw shadow circle under the player

// Calculate distance traveled from jump start (positive value as player moves up)
/// @type {Real}
var distance_from_start = jump_y_start - y;  // Positive when moving up

// Clamp distance to max jump height
/// @type {Real}
var clamped_distance = clamp(distance_from_start, 0, max_jump_height);

// Scale the shadow based on jump height using lerp
// At ground (distance = 0): scale = 1.0
// At peak (distance = max_jump_height): scale = 0.3
/// @type {Real}
var shadow_scale = lerp(1.0, 0.7, clamped_distance / max_jump_height);

// Shadow ellipse properties
/// @type {Real}
var shadow_width = 32;  // Base width of shadow (wider for perspective, scaled for 4x sprite)

/// @type {Real}
var shadow_height = 6;  // Base height of shadow (smaller for perspective, scaled for 4x sprite)

/// @type {Real}
var shadow_y = jump_y_start;  // Position at ground where jump started

// Draw the shadow ellipse
draw_set_alpha(0.5);  // Semi-transparent
draw_set_color(c_black);
draw_ellipse(
    x - shadow_width * shadow_scale,
    shadow_y - shadow_height * shadow_scale,
    x + shadow_width * shadow_scale,
    shadow_y + shadow_height * shadow_scale,
    false
);
draw_set_alpha(1.0);  // Reset alpha
draw_set_color(c_white);  // Reset color

// Draw the player only if visible (for blinking effect during invincibility)
if (is_visible) {
    draw_self();
}

// Draw lives UI in top-left corner with shadow
/// @type {Real}
var shadow_offset = 4;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed(10 + shadow_offset, 40 + shadow_offset, "Lives: " + string(lives), 3, 3, 0);
draw_set_color(c_white);
draw_text_transformed(10, 40, "Lives: " + string(lives), 3, 3, 0);

// Draw score UI in top-right corner with shadow
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed(room_width - 10 + shadow_offset, 40 + shadow_offset, "Score: " + string(global.score), 3, 3, 0);
draw_set_color(c_white);
draw_text_transformed(room_width - 10, 40, "Score: " + string(global.score), 3, 3, 0);

// Draw text in middle
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_text_transformed(room_width / 2 + shadow_offset, 55 + shadow_offset, "The gm(48) is coming soon", 2, 2, 0);
draw_set_color(c_white);
draw_text_transformed(room_width / 2, 55, "The gm(48) is coming soon", 2, 2, 0);


// Reset text alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
