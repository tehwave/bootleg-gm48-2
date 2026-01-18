/// Cat Create Event
/// Initialize movement and perspective scaling configuration

/// @type {Real}
current_speed = 0; // Will be set by spawner

/// @type {Real}
target_x = -100; // X position of despawner

/// @type {Real}
target_y = 0; // Y position of despawner

/// @type {Real}
despawn_distance = 50; // How close to despawner before destruction

/// @type {Real}
scale_multiplier = 0; // Easing curve multiplier (set by spawner)

/// @type {Real}
speed_multiplier = 0; // Speed growth multiplier (set by spawner)

/// @type {Real}
max_scale = 0; // Maximum scale before stopping growth (set by spawner)

/// @type {Real}
max_speed = 0; // Speed cap (set by spawner)

// Collision tracking
/// @type {Bool}
collected = false; // Set to true when player collects this cat
