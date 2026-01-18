// Game over controller variables

/// @type {Bool}
can_restart = false;  // Prevent restart until delay finishes

// Set alarm for 2 second delay
alarm[0] = game_get_speed(gamespeed_fps) * 2;  // 2 seconds
