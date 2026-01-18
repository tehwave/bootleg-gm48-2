# GameMaker Studio 2 Project — Stitch VSCode Edition

## Project Overview

A GameMaker Studio 2 endless runner game project (bootleg-gm48-2) edited using Stitch for VSCode. The player controls a character avoiding obstacles that continuously spawn, with difficulty increasing over time. Created for a game jam.

## Tech Stack

- **Engine:** GameMaker Studio 2 (IDE version 2024.14.2.213)
- **Language:** GML (GameMaker Language)
- **Editor:** VSCode with Stitch extension
- **Type System:** GameMaker Feather with Stitch enhancements
- **Runtime:** VM (default) or YYC compilation available

## Development Workflow

### Opening and Running the Project

- Use **Stitch: Open in GameMaker** (command palette) to open the project in the correct GameMaker IDE version
- Press **F5** to run the project directly from VSCode via Stitch
- Stitch will compile with VM by default; switch to YYC via the status bar or `stitch.run.defaultCompiler` setting

### File Organization

- **`objects/`** — Game objects (player, spawner, obstacles, background controller)
  - Each object has a `.yy` file and event files (e.g., `Create_0.gml`, `Step_0.gml`)
  - File naming: `EventName_N.gml` (e.g., `Create_0.gml`, `Step_0.gml`)
- **`sprites/`** — Sprite assets with frame definitions
- **`rooms/`** — Room definitions (currently Room1)
- **`datafiles/`** — Included files (managed in VSCode Explorer)
- **Root `.yyp` file** — Project configuration (don't edit directly)

### Creating New Assets with Stitch

- **Objects:** Right-click a folder in the Stitch tree → "New Object"
- **Sprites:** Drag images into Stitch tree or use "New Sprite..." context menu
- **Sounds:** Drag audio files or use "New Sound..."
- **Scripts:** Right-click folder → "New Script"

**If you add .yy files manually:** Set `parent` to the project root, e.g. `"path":"bootleg-gm48-2.yyp"` (see existing objects). Do not use `folders/Objects.yy`, or the project will fail to link.

## GML Code Conventions

### Variable Declaration & Types

Always declare variables with explicit types using JSDoc `@type` tags when the type isn't obvious:

```gml
/// @type {Real}
var speed = 5;

/// @type {Array<String>}
var names = [];

/// @type {Id.Instance.player}
var player_inst = noone;
```

**Why:** Stitch uses Feather's type system and only infers types at declaration. Ambiguous types can cause surprises later.

### Function Documentation

Use JSDoc for all custom functions:

```gml
/// @description Moves the player in a direction with speed control.
/// @param {Real} dir - Direction in degrees (0-360)
/// @param {Real} spd - Movement speed
/// @returns {Void}
function move_player(dir, spd) {
  x += lengthdir_x(spd, dir);
  y += lengthdir_y(spd, dir);
}
```

### Context Awareness with `@self` Tag

Use `@self` tag to specify context in `with` statements and constructors:

```gml
/// @self {Struct.Player}
with (player_inst) {
  speed += 1;
}

/// @self {Function.create_player}
function initialize() {
  level = 1;
}
```

### Instance, Global, and Local Variables

Declare dynamically-created variables explicitly:

```gml
/// @instancevar {Real} bullet_damage
var damage = 10;

/// @globalvar {Array<Id.Instance>} ALL_ENEMIES
global.enemies = [];

/// @localvar {String} temp_string
if (!variable_instance_exists(id, "temp")) {
  temp = "hello";
}
```

### Naming Conventions

- **Variables:** `snake_case` (e.g., `player_speed`, `max_health`)
- **Functions:** `snake_case` (e.g., `move_player()`, `spawn_enemy()`)
- **Constants/Macros:** `UPPER_SNAKE_CASE` (e.g., `MAX_SPEED`, `SPRITE_SCALE`)
- **Objects:** Lowercase with prefix (e.g., `player`, `obj_obstacle`, `enemy`)
- **Sprites:** Prefix with `sp_` (e.g., `sp_player`, `sp_bullet`, `sp_explosion`)
- **Sounds:** Prefix with `snd_`, `mus_`, or `amb_` (e.g., `snd_jump`, `mus_theme`, `amb_wind`)

### Object Event Conventions

Structure object events logically:

- **Create Event** (`Create_0.gml`) — Initialize variables and state
- **Step Event** (`Step_0.gml`) — Update game logic each frame
- **Draw Event** (`Draw_0.gml`) — Render the object
- **Collision Events** (`Collision_<obj>.gml`) — Handle interactions
- **Destroy Event** (`Destroy_0.gml`) — Cleanup resources

### Comments

Use descriptive comments sparingly (code should be self-documenting):

```gml
// Good: explains WHY
/// Check if player is grounded before allowing jump
if (y + sprite_height >= ground_level) {
  can_jump = true;
}

// Bad: explains WHAT (obvious from code)
// Set x to x plus velocity
x += velocity;
```

## Using Stitch Features

### Intellisense & Navigation

- **Go to Definition:** `F12` or `Ctrl+Click` on a symbol
- **Find References:** `Shift+F12` to see all uses of a symbol
- **Rename:** `F2` to rename a symbol everywhere (including references in comments)
- **Symbol Search:** `Ctrl+T` to find globals, assets, and object events

### Type Hints and Autocomplete

Stitch provides autocomplete for:
- Built-in GameMaker functions and constants
- Your custom functions and variables
- Asset IDs (sprites, objects, sounds, etc.)
- Feather types in JSDoc comments

Accept autocompletes with `Tab` or `Enter`.

### Asset Renaming via Tree

Use the Stitch sidebar to rename assets directly while maintaining parent/child relationships. Stitch will auto-update references in code.

### Included Files ("Datafiles")

- Add files to the `datafiles/` folder in VSCode's Explorer
- Stitch automatically syncs the `.yyp` to match the actual folder contents
- Use the Stitch sidebar to see a quick view of your datafiles
- Right-click in the tree to "Reveal in Explorer View"

## Common GameMaker Patterns

### Player Movement (Horizontal/Vertical)

```gml
// In player Create event
/// @type {Real}
move_speed = 4;

/// @type {Real}
jump_force = 12;

/// @type {Bool}
is_grounded = false;

// In player Step event
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);

// Horizontal movement
x += (key_right - key_left) * move_speed;
x = clamp(x, 0, room_width);

// Jump mechanics
if (key_jump && is_grounded) {
  velocity_y = -jump_force;
  is_grounded = false;
}
```

### Spawning Obstacles at Regular Intervals

```gml
// In spawner Create event
/// @type {Real}
spawn_timer = 0;

/// @type {Real}
spawn_delay = 60; // frames between spawns

// In spawner Step event
spawn_timer -= 1;

if (spawn_timer <= 0) {
  instance_create_layer(
    room_width,
    random_range(100, room_height - 100),
    "Instances",
    obstacles
  );
  spawn_timer = spawn_delay;
}
```

### Collision Detection (Game Over)

```gml
// In player Step event
if (place_meeting(x, y, obstacles)) {
  // End game on collision
  game_end();
  // Or transition to game over state
  // state = "game_over";
}
```

### Endless Scrolling Background

```gml
// In background controller Create event
/// @type {Real}
scroll_speed = 3;

/// @type {Real}
bg_x = 0;

// In Step event
bg_x -= scroll_speed;

if (bg_x <= -room_width) {
  bg_x += room_width; // Loop the background
}

// In Draw event
draw_sprite(sp_background, -1, bg_x, 0);
draw_sprite(sp_background, -1, bg_x + room_width, 0);
```

### State Machines (Recommended)

Use for game states (playing, game over, menu, etc.):

```gml
/// @type {String}
state = "playing";

switch (state) {
  case "playing":
    // Update gameplay
    break;
  case "game_over":
    // Show game over UI
    if (keyboard_check_pressed(vk_space)) {
      state = "playing";
      game_restart();
    }
    break;
  case "paused":
    // Game paused logic
    break;
}
```

## Known Limitations (Stitch Parser)

- **Macros:** Only simple, complete expressions are supported
- **Extraneous braces:** `{ }` wrapping random code sections will cause errors
- **IIFEs:** Immediately-invoked function expressions `(function(){})()` are not supported
- **Variable Definitions via UI:** Not supported; define instance variables in Create events instead

**Workaround:** If you encounter parser errors, check for these patterns and refactor if possible.

## Known Issues — Manual .yy File Creation

When creating new objects manually (not via Stitch UI):

1. **Required JSON fields in object `.yy` files:**
   - Must include `"$GMObject":""` type tag at the start of the JSON
   - Must include `"managed":true` field (boolean)
   - Field order matters; follow the structure in existing objects (see `objects/obstacles/obstacles.yy` as reference)

2. **Parent path syntax:**
   - Use `"path":"bootleg-gm48-2.yyp"` for parent (project root), NOT `"path":"folders/Objects.yy"`
   - Incorrect parent path will cause the object to fail linking

3. **Project resource registration:**
   - All new objects MUST be registered in `bootleg-gm48-2.yyp` under the `resources` array
   - Format: `{"id":{"name":"object_name","path":"objects/object_name/object_name.yy",},},`
   - Without this, objects will not appear in the GameMaker IDE even if files exist

4. **Instance creation in rooms:**
   - New object instances must be added to both:
     - `instanceCreationOrder` array (for load order)
     - `instances` array in the appropriate layer (for placement/configuration)
   - Reference the object path correctly: `{"name":"object_name","path":"objects/object_name/object_name.yy",}`

5. **Event registration in object `.yy` files:**
   - Even if event files (e.g., `Create_0.gml`, `Step_0.gml`) exist in the directory, they won't appear in the IDE unless registered in the object's `eventList` array
   - Add entries for each event: `{"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":TYPE,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",}`
   - **Event type codes:** 0=Create, 1=Destroy, 2=Alarm, 3=Step, 4=Draw, 5=KeyPress, 6=KeyRelease, 7=GameStart, 8=GameEnd, 9=RoomStart, 10=RoomEnd, 11=AnimationEnd, 12=AnimationUpdate, 13=AsyncImageLoaded, 14=AsyncAudioLoaded, 15=AsyncAudioPlayback, 16=AsyncHTTP, 17=AsyncDialogAsync, 18=AsyncSocial, 19=AsyncCloud, 20=AsyncNetworking, 21=AsyncSteam, 22=AsyncSystem, 23=AsyncPushNotification, 24=AsyncSaveLoad, 25=AsyncAudioRecording, 26=AsyncSaveToDevice, 27=AsyncLoadFromDevice, 28=AsyncFunction, 29=GestureEvent, 30=PreCreate
   - Without this, event files won't load even if the `.gml` files are present

## Debugging and Logs

- Run your project with **F5** — output appears in the VSCode Terminal or Stitch Runner Panel
- View Stitch logs via Output panel → "Stitch" dropdown for troubleshooting
- Use `show_debug_message()` for debugging output:
  ```gml
  show_debug_message("Player x: " + string(x) + ", y: " + string(y));
  ```

## Configuration File (Optional)

You can create a `stitch.config.json` next to the `.yyp` file to:

1. **Enforce naming conventions** for new assets:
   ```json
   {
     "newSpriteRules": {
       "allowedNames": ["^sp_"]
     },
     "newSoundRules": {
       "allowedNames": ["^(snd|mus|amb)_"]
     }
   }
   ```

2. **Color-code console output** in the Runner Panel for log levels:
   ```json
   {
     "gameConsoleStyle": {
       "base": "color:#808080;",
       "lines": [
         {
           "pattern": "\\berror\\b",
           "base": "color: #FF0000; font-weight: bold;"
         },
         {
           "pattern": "\\bwarn(ing)?\\b",
           "base": "color: #FFD900"
         }
       ]
     }
   }
   ```

## Recommended VSCode Extensions

Pair Stitch with these extensions for a better experience:

- **Code Spell Checker** — Spell check for GML code and comments
- **Change Case** — Quick text casing transformations
- **TabOut** — Smarter keyboard navigation
- **Better Comments** — Highlight important comment types

## Source Control Best Practices

**Always use Git!** Stitch can make large-scale, irreversible changes to your project.

- Commit before renaming assets or bulk refactoring
- Commit before importing assets from other projects
- Use `.gitignore` to exclude build artifacts and IDE cache:
  ```
  *.yyc
  .DS_Store
  .cache/
  ```

## Performance Tips

- Use **VM** for fast iteration during development
- Switch to **YYC** when testing final builds
- Profile frequently using GameMaker's built-in profiler
- Keep sprite frame counts reasonable (memory is limited on some targets)

## Resources

- [GameMaker Official Docs](https://docs.yoyogames.com/)
- [Feather Type System](https://docs.yoyogames.com/Home.html) (built into GameMaker)
- [Stitch GitHub](https://github.com/bscotch/stitch) (issue tracker, feature requests)
- [JSDoc Type Syntax](https://jsdoc.app/tags-type.html) (for `@type`, `@param`, `@returns`)
