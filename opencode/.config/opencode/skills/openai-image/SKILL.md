---
name: OpenAI image generation
description: Generate and save a PNG image with the OpenAI Images API using the local generate_image.py script. Use when the user requests an OpenAI-generated image.
slash: true
---

## Generate an image with OpenAI

Use the shell tool to run `python3 generate_image.py`. The script calls the OpenAI Images API and saves a PNG; it prints the saved absolute path on success. Set the shell timeout to **at least 300000 milliseconds**.

1. Obtain the user's image prompt. Preserve their subject, style, and constraints; do not substitute an unrelated image. Ask for a prompt if none was provided.
2. Choose a descriptive, unused `.png` destination in the user's current project (for example, `images/sunset-over-lake.png`), unless the user provided an output file path. The script creates missing parent directories and refuses to overwrite an existing file.
3. Run the script with `--prompt` and `--output`, safely quoting each shell argument, especially prompts containing apostrophes:

   ```sh
   python3 generate_image.py --prompt 'a watercolor fox in a forest' --output images/watercolor-fox.png
   ```

4. Use `--size 1536x1024` for a requested landscape image or `--size 1024x1536` for portrait; otherwise the default is `1024x1024`. Use `--quality low` for cheaper drafts when requested; otherwise the default is `medium`.
5. Wait for completion. Report the actual saved absolute path and briefly describe the image. If generation fails, report the real error rather than claiming an image was made.

The script reads `OPENAI_API_KEY` from its environment. Never print or request the key. Do not make a direct API request in place of using the script.
