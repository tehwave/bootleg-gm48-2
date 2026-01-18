/// Spawner Step Event
/// Handle obstacle spawning at regular intervals

spawn_timer -= 1;

if (spawn_timer <= 0) {
  /// Find despawner instance to get its position
  var despawner_inst = instance_find(obj_despawner, 0);
  
  // Increment cat spawn counter
  cat_spawn_counter += 1;
  
  // Decide whether to spawn obstacle or cat
  /// @type {Bool}
  var spawn_cat = (cat_spawn_counter >= cat_spawn_interval);
  
  if (spawn_cat) {
    /// Create cat at spawner position with initial perspective scaling
    var cat = instance_create_layer(x, y, "Instances", obj_cat);
    
    /// Pass spawn configuration to cat
    /// @self {Id.Instance.obj_cat}
    with (cat) {
      image_scale = other.initial_scale;
      current_speed = other.initial_speed;
      // Get despawner position if it exists
      if (despawner_inst != noone) {
        target_x = despawner_inst.x;
        target_y = despawner_inst.y;
      } else {
        // Fallback position if despawner doesn't exist
        target_x = -100;
        target_y = other.y;
      }
      scale_multiplier = other.scale_growth_rate; // Easing curve for perspective
      speed_multiplier = other.speed_growth_rate; // Speed growth easing
      max_scale = other.max_scale; // Inherit max scale from spawner
      max_speed = other.max_speed; // Inherit max speed from spawner
    }
    
    // Reset cat counter
    cat_spawn_counter = 0;
  } else {
    /// Create obstacle at spawner position with initial perspective scaling
    var obstacle = instance_create_layer(x, y, "Instances", obj_obstacle);
    
    /// Pass spawn configuration to obstacle
    /// @self {Id.Instance.obj_obstacle}
    with (obstacle) {
      image_scale = other.initial_scale;
      current_speed = other.initial_speed;
      // Get despawner position if it exists
      if (despawner_inst != noone) {
        target_x = despawner_inst.x;
        target_y = despawner_inst.y;
      } else {
        // Fallback position if despawner doesn't exist
        target_x = -100;
        target_y = other.y;
      }
      scale_multiplier = other.scale_growth_rate; // Easing curve for perspective
      speed_multiplier = other.speed_growth_rate; // Speed growth easing
      max_scale = other.max_scale; // Inherit max scale from spawner
      max_speed = other.max_speed; // Inherit max speed from spawner
    }
  }
  
  // Add variance: spawn_delay (fastest) + 60-120 frames (1-2 seconds slower)
  spawn_timer = spawn_delay + random_range(60, 120);
}
