# Field Command — Godot Project

Stage 1 prototype for Field Command, built in Godot 4.6.

## Opening the project

1. Launch Godot: `C:\Users\fletc\Godot\Godot_v4.6.2-stable_win64.exe`
2. On the Project Manager, click **Import**.
3. Browse to `C:\Users\fletc\Field-Command\game\project.godot` and open it.
4. Godot will load the project. The editor opens with `main.tscn` available in `scenes/`.
5. Press **F5** (or the Play button top-right) to run.

First run prompts you to pick a main scene — select `scenes/main.tscn`. After that, F5 just plays.

## What you should see

A black window with "FIELD COMMAND" in bone-white stencil text and "PROTOTYPE 0.0.1 // GODOT 4" underneath. Top-left HUD reads "FIELD COMMAND // SECTOR 7 // BOOT OK".

That's it. The engine is booted. From here we build the actual game.

## Folder layout

```
game/
├── project.godot       Godot project config
├── icon.svg            Project icon
├── scenes/
│   └── main.tscn       Entry scene (title screen)
├── scripts/
│   └── main.gd         Entry script
└── README.md           This file
```

We'll add more folders as we build (`units/`, `buildings/`, `ui/`, `factions/`, `assets/`).

## Roadmap

### Prototype 0.1 — Single unit, single command
- [ ] Move a rifle squad with right-click
- [ ] Select with left-click drag-box
- [ ] Basic terrain (flat isometric-ish top-down grid)

### Prototype 0.2 — Combat
- [ ] Enemy unit spawns
- [ ] Attack on contact, HP bars, death animation
- [ ] Unit deselection, formation movement

### Prototype 0.3 — Base
- [ ] Place a command center
- [ ] Train units from the command center
- [ ] Resource counter (command points)

### Prototype 0.4 — Vs AI
- [ ] Enemy AI that builds and attacks
- [ ] Win/lose condition
- [ ] Match restart

### Prototype 0.5 — Hero
- [ ] Spawn Viper with abilities
- [ ] Level up on kills
- [ ] Ultimate ability (precision volley)

### Prototype 1.0 — Playable demo
- [ ] One faction (Coalition), one map, vs-AI skirmish
- [ ] Real art, not programmer rectangles
- [ ] Export to Windows .exe for playtesting

Multiplayer is phase 2. Get single-player fun first.

## Running the game from the command line

```bash
# from the game/ directory:
"C:/Users/fletc/Godot/Godot_v4.6.2-stable_win64.exe" --path . --scene scenes/main.tscn
```

Useful for testing without opening the editor.
