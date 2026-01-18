/// Obstacles Draw Event
/// Draw sprite with smooth scale animation

/// Draw right-offset black shadow
draw_sprite_ext(sprite_index, image_index, x + 8, y + 4, image_scale, image_scale, image_angle, c_black, image_alpha * 0.5);

draw_sprite_ext(sprite_index, image_index, x, y, image_scale, image_scale, image_angle, c_white, image_alpha);
