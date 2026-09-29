# Krea 2 Turbo: practical prompting notes

Additional guidance for writing plain-text prompts for Krea 2. Use the instructions in `SKILL.md` for prompt expansion.

## Prompting and iteration

* Krea recommends natural-language descriptions. A short concept can already produce good images; a longer, coherent description usually gives more precise results. Avoid disconnected tag soup. Describe the subject and action, their spatial relationships, the setting, then the desired medium, composition, lighting, palette and texture *when relevant*. Preserve the user's requested medium and details; don't pad with invented props or competing styles.
* For an open-ended request, start with a simple subject rather than inventing many details. Add a small style cue (e.g. “retro cartoon illustration” or “grainy lo-fi VHS still”) if it helps narrow the range; add further concrete details when the user asks for refinement. If the user already provided a detailed brief, follow it rather than exploring a different aesthetic.
* Krea 2 can render intentionally rough, grainy, low-resolution or experimental looks; don't automatically polish such requests into glossy photography. Specify the texture and medium you want.
* Put **exact visible words in double quotes**: `a sign reading "OPEN LATE"`. Keep lettering requests short; text rendering may require checking in the resulting image.
* When a pose is crucial, describe observable geometry instead of only naming it: which leg supports the weight, arm and hand positions, torso and head direction, gaze, silhouette and motion. Use only details visible in the chosen framing; a close-up cannot reliably show foot placement. For an interaction, name which hand touches or holds which object and where.
* A style description works best when it is concrete and internally consistent: name the medium, mark-making or surface texture, lighting, color treatment and composition. One well-matched style direction beats several conflicting style paragraphs. Keep the subject/action more prominent than decorative style prose.

## Plain-text prompt scope

* Krea's hosted image tool offers style references and moodboards, but those are separate controls, not instructions that a text prompt can provide. If the user asks to match a reference, describe its relevant visual qualities in words when they are available; do not claim pixel-accurate style transfer or moodboard support from the prompt alone.
* Weighted markup such as `(phrase:1.5)`, negative weights, and pose blocks depend on particular third-party workflows; they are not standard Krea 2 prompt syntax. Use ordinary natural-language descriptions of the desired framing and appearance instead.
