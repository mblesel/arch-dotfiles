---
name: ComfyUI image generation
description: Generate images with the local ComfyUI server using comfy-generate, and start or stop the server with comfy-start and comfy-stop.
slash: true
---

## Local ComfyUI image generation

The commands `comfy-start`, `comfy-generate`, and `comfy-stop` are available on `PATH`. Run them as shell commands; do not call the ComfyUI HTTP API directly for this workflow.

### Generate an image

1. Obtain the user's image prompt; ask for one if none was supplied. Read `krea2.md` in this skill directory before preparing the generation prompt.
2. Improve the user's prompt according to `krea2.md`: preserve the requested subject, actions, relationships, medium, and other explicit details. Compose a single cohesive prompt paragraph; keep the planning internal. If the original prompt is already detailed, make only light improvements.
3. Run `comfy-start` first. It reports whether the local server is already running or starts it and waits until it is ready. If it fails, report the error rather than attempting generation.
4. Pass the **improved prompt**, safely quoted as one shell argument, to `comfy-generate`. Wait for the command to finish. Its stdout contains the saved image path(s); progress messages go to stderr. Report the actual returned path(s) to the user.

Optional generation arguments:

* `-o DIRECTORY` or `--output-path DIRECTORY` sets the image save directory on the ComfyUI server; the default is `/tmp/`.
* `-a RATIO` or `--aspect-ratio RATIO` accepts `1:1` (default), `2:3` (portrait), or `3:2` (landscape).

For example, after improving a user prompt into a single paragraph: `comfy-generate 'a watercolor fox in a forest, softly lit, with the fox clearly framed among the trees' -a 2:3 -o /tmp/illustrations/`. Pass the user's requested directory and aspect ratio when specified. Do not invent an image path or claim success if the command fails.

### Server lifecycle

* Run `comfy-start` when the user asks to start ComfyUI or before generating an image. It is safe when the server is already running.
* Run `comfy-stop` when the user asks to stop ComfyUI. It checks whether the server is running and waits for shutdown. Do not stop an already-running server just because an image was generated.
