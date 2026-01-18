/// Spawner Create Event
/// Initialize spawn timing and obstacle configuration

/// @type {Real}
spawn_timer = 0;

/// @type {Real}
spawn_delay = 60; // Frames between obstacle spawns

/// @type {Real}
initial_scale = 0.01; // Obstacles start very small (nearly invisible, growing perspective effect)

/// @type {Real}
scale_growth_rate = 0.02; // Lerp interpolation rate towards max scale

/// @type {Real}
initial_speed = 1.5; // Starting movement speed

/// @type {Real}
speed_growth_rate = 0.02; // How much speed increases per frame (easing curve)

/// @type {Real}
max_scale = 1.5; // Maximum scale to prevent growing too large

/// @type {Real}
max_speed = 8; // Maximum speed cap

/// @type {Real}
cat_spawn_counter = 0; // Counts obstacles spawned

/// @type {Real}
cat_spawn_interval = 10; // Spawn a cat every N obstacles
