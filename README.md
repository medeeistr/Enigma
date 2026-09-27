# 🧩 Enigma - A 2D Platformer Adventure

**Enigma** is a 2D platformer adventure game built in **Godot Engine 4**. In this journey, a brave prince must navigate through a challenging level to reach his destiny, but his path is blocked by mysterious trials that test both his agility and his mind.

---

## 🌟 About the Game
As you move through the platformer level, stepping into specific challenge zones will freeze the player's movement and open interactive mini-games. Your survival depends on your wits: if you fail a challenge, you lose one of your precious lives. If you succeed, the prince continues his journey toward victory!

### 🎮 Key Features:
* **Fluid Platformer Mechanics:** Built using `CharacterBody2D` with responsive left/right controls and a smart locking system that pauses movement during active challenges.
* **Global Lives System & UI:** A centralized state manager (`Global.gd`) tracks your 3 lives, while the interface (`InimiUI.gd`) updates dynamically in real-time, hiding hearts as damage is taken.
* **Three Unique Mini-Games:**
  1. **The Choice Challenge:** Test your luck and logic by picking the safe path among three slots, avoiding the randomly generated dangerous one.
  2. **Timed 4x4 Sudoku:** A classic puzzle challenge packed into a 30-second countdown where you must fill and solve the grid.
  3. **Interactive Riddles:** A clever text-based puzzle system where typing the correct answer to ancient questions is the only way forward.
* **Complete Game Flow:** Seamless transitions between the Start Menu (`start.tscn`), the main adventure (`Nivel1.tscn`), the Victory screen (`finish.tscn`), and the Game Over screen (`game_over.tscn`) which lets you instantly retry.

---

## 🕹️ Controls
* **Move Left / Right:** `Left` / `Right` Arrow keys.
* **Interactions / Inputs:** Left Mouse Click for buttons and typing for riddles.

---

## 🛠️ Technical Highlights & Architecture
Under the hood, the project implements clean, robust architecture in **GDScript (Godot 4)**:
* **Global State Management:** Keeps track of persistent data (like player lives) across different scene changes without losing state.
* **Safe Scene Tree Management:** Utilizes Godot's `call_deferred()` for safe, frame-independent scene transitions during critical physics callbacks.
* **Dynamic Scene Instantiation:** Mini-games are loaded dynamically (`load().instantiate()`) directly into the active scene tree and handle their own cleanup (`queue_free()`) upon completion.

---

## 🚀 How to Run Locally
1. Download and install **Godot Engine 4** (version 4.x recommended).
2. Clone or download this repository to your computer.
3. Open Godot, click on **Import**, and select the `project.godot` file from the project folder.
4. Press **F5** inside the editor to run the game and enjoy the adventure!

---
