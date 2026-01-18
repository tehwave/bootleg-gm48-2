// Movement and physics variables
/// @type {Real}
jump_force = 20;  // How strong the jump is (configurable)

/// @type {Real}
gravity_strength = 0.8;  // How fast player falls (configurable)

/// @type {Real}
velocity_y = 0;  // Current vertical velocity

/// @type {Real}
max_fall_speed = 20;  // Terminal velocity (configurable)

/// @type {Bool}
is_grounded = false;  // Is player on ground?

/// @type {Bool}
can_jump = true;  // Can player jump? (prevents multi-jump)

/// @type {Real}
peak_threshold = 2;  // Velocity threshold to detect top of jump (configurable)

// Ground reference for collision checks
/// @type {Asset.GMObject}
ground_obj = obj_ground;

// Sprite states (you'll need to create these sprites)
/// @type {Asset.GMSprite}
sprite_idle = spr_player_animated;  // Default grounded sprite

/// @type {Asset.GMSprite}
sprite_jump_mid = spr_player_jump_mid;

/// @type {Asset.GMSprite}
sprite_jump_peak = spr_player_jump_peak;

// Set initial sprite
sprite_index = sprite_idle;

// Track the y position where jump started (for shadow positioning)
/// @type {Real}
jump_y_start = y;

// Calculate max jump height based on physics (v^2 / 2a)
/// @type {Real}
max_jump_height = (jump_force * jump_force) / (2 * gravity_strength);

// Lives system
/// @type {Real}
lives = 3;  // Player starts with 3 lives

/// @type {Bool}
is_invincible = false;  // Invincibility state after taking damage

// Score system
/// @globalvar {Real} score
global.score = 0;  // Initialize score at game start

/// @type {Real}
blink_timer = 0;  // Timer for blinking effect

/// @type {Real}
blink_interval = 5;  // Blink every 5 frames

/// @type {Bool}
is_visible = true;  // Controls sprite visibility for blinking