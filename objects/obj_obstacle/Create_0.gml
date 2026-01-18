/// Obstacles Create Event
/// Initialize movement and perspective scaling configuration

/// @type {Asset.GMSprite}
var obstacles = [spr_obstacles_1, spr_obstacles_3, spr_obstacles_4, spr_obstacles_5, spr_obstacles_6, spr_obstacles_7, spr_obstacles_8, spr_obstacles_9];
sprite_index = obstacles[irandom(array_length(obstacles) - 1)];

/// @type {Real}
image_index = random(image_number);

image_speed=0

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

// Collision tracking (used to determine if score should be awarded)
/// @type {Bool}
hit_player = false;  // Set to true if destroyed by player collision
