// Check if player is on ground
is_grounded = place_meeting(x, y + 1, ground_obj);

// Handle jump input (Space key)
if (keyboard_check_pressed(vk_space) && is_grounded && can_jump) {
    velocity_y = -jump_force;
    is_grounded = false;
    can_jump = false;
    jump_y_start = y;  // Record where the jump started
}

// Reset jump ability when grounded
if (is_grounded) {
    velocity_y = 0;
    can_jump = true;
    jump_y_start = y;  // Reset shadow position once landed
}

// Apply gravity when in air
if (!is_grounded) {
    velocity_y += gravity_strength;
    
    // Cap falling speed
    if (velocity_y > max_fall_speed) {
        velocity_y = max_fall_speed;
    }
}

// Apply vertical movement
y += velocity_y;

// Collision with ground - snap to ground surface
if (place_meeting(x, y, ground_obj)) {
    while (place_meeting(x, y, ground_obj)) {
        y -= 1;
    }
    velocity_y = 0;
    is_grounded = true;
}

// Update sprite based on state
if (is_grounded) {
    // On ground - use idle sprite
    sprite_index = sprite_idle;
} else {
    // In air - check if at peak or jumping/falling
    if (abs(velocity_y) < peak_threshold) {
        // At the top of jump - velocity near zero
        sprite_index = sprite_jump_peak;
    } else {
        // Jumping up or falling down - use midair sprite
        sprite_index = sprite_jump_mid;
    }
}

// Handle blinking during invincibility
if (is_invincible) {
    // Update blink timer
    blink_timer += 1;
    if (blink_timer >= blink_interval) {
        is_visible = !is_visible;  // Toggle visibility
        blink_timer = 0;
    }
}

// Check collision with obstacles (only if not invincible)
if (!is_invincible && place_meeting(x, y, obj_obstacle)) {
    /// @type {Id.Instance.obj_obstacle}
    var hit_obstacle = instance_place(x, y, obj_obstacle);

    if (hit_obstacle != noone) {
        // Reduce lives
        lives -= 1;

        // Mark obstacle as hit by player (no score awarded)
        hit_obstacle.hit_player = true;

        // Destroy the obstacle
        instance_destroy(hit_obstacle);

        // Check if game over
        if (lives <= 0) {
            room_goto(rm_game_over);
        } else {
            // Activate invincibility using alarm (5 seconds = 300 steps at 60fps)
            is_invincible = true;
            alarm[0] = game_get_speed(gamespeed_fps) * 5;  // 5 seconds
            blink_timer = 0;
            is_visible = true;
        }
    }
}

// Check collision with cats (collectible - adds score or extra life)
if (place_meeting(x, y, obj_cat)) {
    /// @type {Id.Instance.obj_cat}
    var hit_cat = instance_place(x, y, obj_cat);

    if (hit_cat != noone && !hit_cat.collected) {
        // Mark as collected to prevent double collection
        hit_cat.collected = true;

        // Award bonus (extra life or score)
        lives += 1;

        // Destroy the cat
        instance_destroy(hit_cat);
    }
}