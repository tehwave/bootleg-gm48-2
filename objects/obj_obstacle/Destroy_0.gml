/// Obstacles Destroy Event
/// Clean up when obstacle is destroyed (placeholder for future sound/particle effects)

// Award score if obstacle was destroyed by reaching despawner (not by player collision)
if (!hit_player) {
    global.score += 1;
}

// Can add sound effects or particle systems here later
