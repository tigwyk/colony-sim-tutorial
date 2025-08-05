# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a colony simulation game built in Godot 4, following a YouTube tutorial series. The game implements a tile-based grid system where colonists can navigate, build structures, manage resources, and perform tasks in a simulated colony environment.

## Development Environment

**Engine**: Godot 4.4
**Language**: GDScript
**Main Scene**: `res://scenes/Main/Main.tscn`
**Project Type**: Mobile-optimized 2D game

## Core Architecture

### Entity-Component Structure
- **Entities**: Core game objects (Unit, Building, Item, Plant, Cell, Zone)
- **Services**: System managers (Controller, Grid, Pathfinding, TaskManager, ZoneHelper)
- **Types**: Data definitions (BuildingType, FloorType, ItemType, PlantType)

### Key Systems

**Grid System** (`scripts/Service/Grid.gd`):
- Central game world representation using Dictionary-based grid
- Manages multiple TileMapLayers (floor, building, plant, item, zone, blueprint)
- Handles tile visualization and updates
- Grid coordinates use Vector2i

**Controller System** (`scripts/Service/Controller.gd`):
- Main input handler and state manager
- Manages selection, placement, and zoning states
- Coordinates between user input and game systems
- Uses signal-based communication

**Cell System** (`scripts/Entity/Cell.gd`):
- Individual grid tile representation
- Contains references to floor, building, item, plant, stockpile
- Handles navigation and occupancy logic
- Emits update signals for visual changes

**Zoning System** (`scripts/Service/ZoneHelper.gd`, `scripts/Entity/Zone.gd`):
- Drag-to-create zone functionality
- Supports stockpile and grow zone modes
- Blueprint visualization during placement
- Currently under active development

### Signal Communication Pattern
The codebase heavily uses Godot's signal system for decoupled communication:
- Grid ↔ Controller: `tile_selected`, `tile_move_clicked`  
- Controller ↔ UI: `object_selected`, `startPlacing`, `startZoning`
- Cell updates: `update` signal triggers visual refresh

## File Organization

```
scripts/
├── Entity/           # Game objects (Cell, Building, Item, Plant, Zone, Stockpile)
├── Service/          # System managers (Controller, Grid, Pathfinding, etc.)
├── Task/             # Task system (incomplete)
└── Type/             # Resource definitions

scenes/
├── Main/             # Main game scene and UI
└── Entity/Unit/      # Unit prefabs and logic

data/                 # Resource files (.tres)
├── BuildingType/
├── FloorType/
├── ItemType/
└── PlantType/
```

## Current Development State

Based on README progress tracking:
1. ✅ Tilemap system working
2. ✅ Basic pathfinding implemented  
3. 🔄 Basic AI (in progress)

Recent commits focus on zone system implementation and controller-zonehelper integration.

## Testing and Debugging

**Run Game**: Open in Godot Editor and press F5, or use "Play" button
**Debug**: Use Godot's built-in debugger and print statements
**Scene Testing**: Individual scenes can be tested by setting as main scene

## Common Development Patterns

1. **Adding New Entity Types**: Create resource files in `data/` directory, update corresponding Type class
2. **Extending Grid Functionality**: Modify `Grid.gd` updateCell() method for new visual elements
3. **New Input Handling**: Add to Controller.gd state machine and _input() method
4. **Signal Connections**: Establish in Main.gd _ready() function following existing patterns

## Important Notes

- Grid uses Dictionary with Vector2i keys for O(1) access
- All visual updates should go through Cell.update signal
- State management centralized in Controller with enum-based states
- Resource types loaded from .tres files in data/ directory
- Units use pathfinding service for movement coordination