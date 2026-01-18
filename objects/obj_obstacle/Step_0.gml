/// Obstacles Step Event
/// Move obstacle toward despawner with perspective scaling using easing

/// Move towards target (despawner position)
move_towards_point(target_x, target_y, current_speed);

/// Apply smooth easing growth to scale using lerp
if (image_scale < max_scale) {
  image_scale = lerp(image_scale, max_scale, scale_multiplier);
}

/// Apply smooth easing growth to speed using lerp
if (current_speed < max_speed) {
  current_speed = lerp(current_speed, max_speed, speed_multiplier);
}

/// Destroy when reaching despawner
if (distance_to_point(target_x, target_y) <= despawn_distance) {
  instance_destroy();
}

