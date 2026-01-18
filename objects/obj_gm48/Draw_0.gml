/// Gentle pulse/grow effect for looming presence
gm48_scale = 1 + sin(current_time / 500) * 0.05;
draw_sprite_ext(spr_gm48, -1, x, y, image_xscale * gm48_scale, image_yscale * gm48_scale, 0, c_white, 1);
