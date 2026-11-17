# bunnymark-raylib

A [bunnymark](https://github.com/raysan5/raylib/blob/master/examples/textures/textures_bunnymark.c) port for the
[raylib-bindings](https://github.com/vaiorabbit/raylib-bindings) Ruby gem. It spawns up to 500,000 bouncing bunnies
and displays the frame rate, bunny count and number of batched draw calls.

## Requirements

- Ruby
- The `raylib-bindings` gem, together with a raylib shared library it can load on your platform.

```sh
gem install raylib-bindings
```

On Linux the window is created through GLFW, so a graphical session (X11 or Wayland) is required.

## Running

From the repository root:

```sh
ruby bunnymark-raylib.rb
```

Hold the left mouse button to spawn bunnies at the mouse position (100 per frame). Close the window or press
`Esc` to quit.

## Files

- `bunnymark-raylib.rb` — the demo: window setup, bunny simulation and drawing.
- `resources/wabbit_alpha.png` — bunny sprite.
- `util/setup_dll.rb` — locates the raylib shared libraries and calls `Raylib.load_lib`.
  It uses the installed `raylib-bindings` gem when available and otherwise falls back to a local
  `../lib/raylib` checkout, loading the `raylib`, `raygui` and `physac` libraries for the current platform.
- `util/resource_path.rb` — constants pointing at the example assets in a sibling `raylib-bindings` checkout.
  This demo loads its sprite relative to its own file, so these constants are only there for convenience when
  adapting other raylib examples.

## Notes

`MAX_BATCH_ELEMENTS` mirrors raylib's internal batch size (8192 quads). Once the vertex buffer is full raylib flushes
and starts a new batch, which is why the demo reports `bunnies / MAX_BATCH_ELEMENTS + 1` batched draw calls.
