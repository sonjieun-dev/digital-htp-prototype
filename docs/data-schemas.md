# Data schemas

The prototype captures the **process**, not just the result. The shapes below match what the
component produces (downloadable on the export screen) and map onto `db/schema.sql`.

---

## Stroke JSON (per drawing)

Saved for every drawn symbol. The geometric `summary` is what is fed to the AI — the AI never
"sees" the pixels, only this behavioural description, which reinforces *expert review needed*.

```json
{
  "drawing_id": "uuid",
  "drawing_type": "house | tree | person",
  "canvas": { "width": 1720, "height": 880, "devicePixelRatio": 2 },
  "strokes": [
    {
      "stroke_id": "uuid",
      "tool": "pen | eraser",
      "line_width": 3,
      "started_at": "ISO-8601",
      "ended_at": "ISO-8601",
      "points": [
        { "x": 120, "y": 240, "t": 0 },
        { "x": 124, "y": 244, "t": 16 }
      ]
    }
  ],
  "events": [
    { "type": "undo",  "timestamp": "ISO-8601" },
    { "type": "clear", "timestamp": "ISO-8601" }
  ],
  "undo_count": 1,
  "eraser_count": 0,
  "duration_seconds": 47,
  "png": "data:image/png;base64,...",
  "summary": "12 strokes drawn over 47s; the form is small (occupies ~38% of the canvas), positioned middle-centered; 1 undo, 0 eraser actions; drawn as symbol 1 of 3",
  "blank": false,
  "created_at": "ISO-8601"
}
```

`t` is milliseconds since that stroke began. `started_at`/`ended_at` let you reconstruct
inter‑stroke pauses and total drawing rhythm for expert replay.

---

## Image selection (per symbol)

```json
{
  "selection_id": "uuid",
  "session_id": "uuid",
  "category": "house | tree | person",
  "source": "curated | unsplash | upload",
  "image_url": "...",
  "thumbnail_url": "...",
  "unsplash_photo_id": "...",
  "photographer_name": "...",
  "photographer_profile_url": "...",
  "curated_category_tags": ["isolated house"],
  "selection_type": "primary | most_drawn_to | least_drawn_to",
  "time_to_select_seconds": 42,
  "selected_reason": "user's words",
  "selected_at": "ISO-8601"
}
```

**Unsplash:** when integrating the API, store the photo id, URL, photographer name + profile
URL, and source URL, and display *"Photo by [Photographer] on Unsplash."* The value of the
service is the user's **choice and explanation**, not the image library.

---

## AI reflection (preliminary, for expert review)

The component requests this exact JSON from the model and renders it as the result screen.

```json
{
  "observations": { "house": "1 neutral sentence", "tree": "...", "person": "..." },
  "userWords":     "2-3 sentences summarising the user's own explanations (treated as primary)",
  "symbolic":      ["cautious, open reflection questions — never conclusions"],
  "expertQuestions": ["questions a human expert or the user could explore later"],
  "action":        "one gentle, practical, non-clinical action",
  "preliminary":   "2-3 sentence structured note, explicitly labelled preliminary / not final"
}
```

Result sections rendered, in order:
1. **What can be observed** — neutral, per symbol.
2. **Your words matter** — summary of the participant's own explanations.
3. **Symbolic reflection prompts** — cautious HTP‑inspired questions.
4. **Questions to sit with** — for expert or self.
5. **Preliminary summary for expert review** — labelled *not a final interpretation*.
6. **A small action** — gentle, non‑clinical.
   …followed by a **Safety note** and the **Expert Review Needed** badge.

---

## Session export bundle

The "Download session data" button emits one JSON object:

```json
{
  "participant":  { "participant_id": "uuid", "language": "en", "age": "...", "consent": { } },
  "session":      { "session_id": "uuid", "mode": "draw|image|hybrid", "started_at": "...", "completed_at": "..." },
  "drawings":     [ /* stroke JSON objects */ ],
  "image_selections": [ /* selection objects */ ],
  "followup_answers": { "house": { }, "tree": { }, "person": { } },
  "ai_reflection": { /* the reflection object above */ },
  "chat_messages": [ { "role": "user|assistant", "content": "..." } ]
}
```
