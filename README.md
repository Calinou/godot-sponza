# Sponza demo for Godot 3.x

A nice-looking 3D demo and benchmark for Godot 3.x,
based on the Sponza from Crytek.

![Godot 3 Sponza image 1](https://archive.hugo.pro/.public/godot-sponza/godot_3_sponza_1.jpg)
![Godot 3 Sponza image 2](https://archive.hugo.pro/.public/godot-sponza/godot_3_sponza_2.jpg)

## Try it out

### Installation

Clone the Git repository:

```bash
git clone https://github.com/Calinou/godot-sponza.git
```

You can also
[download a ZIP archive](https://github.com/Calinou/godot-sponza/archive/master.zip)
if you do not have Git installed.

**You need [Godot 3.3.2](https://godotengine.org/article/maintenance-release-godot-3-3-2)
or newer to run this demo.**

Once you have the project files, open the Godot Project Manager, click the
**Import** button, then select the `project.godot` file of this project.
Confirm importing, then edit the project (so that the resources are imported
by the editor). Exit the editor (go back to the project manager), then run
the project. This is to make sure the editor does not render the demo in
the background, which would slow down the running project a lot.

### Controls

- <kbd>W/S/A/D</kbd>: Move forwards/backwards/left/right
- <kbd>Space</kbd>: Move upwards
- <kbd>Left Shift</kbd>: Move downwards
- <kbd>Right Mouse Button</kbd>: Speed modifier (effective when held)
- <kbd>Mouse Wheel</kbd>: Change movement speed (always effective)
- <kbd>Escape</kbd>: Toggle menu
- <kbd>F1</kbd>: Toggle FPS display
- <kbd>F3</kbd>: Toggle frame time graph
- <kbd>F10</kbd>: Toggle mouse capture
- <kbd>F11</kbd> or <kbd>Alt + Enter</kbd>: Toggle fullscreen

## License

Copyright © 2017-2021 Hugo Locurcio and contributors

- Unless otherwise specified, files in this repository are licensed under the
  MIT license, see [LICENSE.md](LICENSE.md) for more information.
- The [Noto Sans](https://www.google.com/get/noto/) fonts are licensed under
  the SIL OFL 1.1, see [fonts/LICENSE.txt](fonts/LICENSE.txt) for more information.
- The [Crytek Sponza](http://www.crytek.com/cryengine/cryengine3/downloads/)
  assets are under the public domain.
