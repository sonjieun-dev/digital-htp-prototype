# Ethics & disclaimers

The single most important principle of this tool:

> **AI does not make the final interpretation. Final interpretation requires expert review.**

This must remain visible across the experience: on the consent screen, before drawing/selection
begins, before and within the AI reflection result, on the exported card, and in chatbot
behaviour.

---

## Positioning

**Do** call it:
- "HTP‑inspired reflection interface"
- "AI‑assisted symbolic reflection"
- "Drawing and image‑based self‑reflection tool"
- "Preliminary observation tool for expert‑guided interpretation"

**Do not** call it:
- "AI HTP test / diagnosis", "AI psychological diagnosis", "AI personality analysis"
- anything implying the AI detects mental illness, trauma, disorder, or pathology

---

## Language rules

**Use** cautious, reflective phrasing:
- "This may suggest…", "One possible reflection is…"
- "This could invite the question…"
- "Rather than concluding, we can explore…"
- "Your own explanation matters more than the image alone."

**Never** use deterministic claims:
- "You are…", "This means you have…", "This proves…", "This shows pathology…"

---

## Chatbot behaviour

- Never diagnose; never infer trauma, illness, disorder, pathology, family dysfunction, or
  personality traits as fact. Avoid clinical labels unless an expert/user provides them.
- Refer to the participant's drawings/choices and prioritise their own description.
- Preferred responses: *"This is something an expert might explore further."*,
  *"Your explanation is essential here."*, *"I can help organize observations, but I cannot
  provide the final interpretation."*

When asked **"What does my drawing mean?"**:
> "I can help you notice visual features, summarize your own explanations, and suggest reflection
> questions. However, I cannot provide a final psychological interpretation. A qualified expert
> should review the drawing in context."

---

## User‑facing disclaimers

**Long (EN):**
> This experience uses AI to organize visual observations, your explanations, and reflective
> questions. The AI does not provide a final psychological interpretation. Any meaningful
> interpretation should be reviewed by a qualified expert in context.

**Short (EN):** "AI‑assisted reflection only. Final interpretation requires expert review."

**Long (KO):**
> 본 서비스는 AI가 그림/이미지의 관찰 내용과 사용자의 설명을 정리하고 성찰 질문을 제안하는
> 도구입니다. AI는 최종 심리 해석을 제공하지 않으며, 의미 있는 해석은 반드시 전문가가 맥락을
> 고려하여 검토해야 합니다.

**Short (KO):** "AI 보조 성찰 도구입니다. 최종 해석은 전문가 검토가 필요합니다."

**Badge:** "Expert Review Needed" / "전문가 검토 필요"

---

## Privacy

- No real names. Anonymous UUIDs only.
- Store images in object storage; keep only storage keys / URLs in the database.
- Disclose exactly what is stored: demographics, drawings, selected images, follow‑up answers,
  AI chat history.
- Provide a data‑deletion option and a research opt‑out.

---

## Expert dashboard (future scope)

A reviewer‑facing surface, not part of the participant flow. Suggested tabs: Overview · House ·
Tree · Person · Cross‑symbol comparison · Chat history · Expert notes · Final interpretation.
Experts review final drawings, stroke‑JSON replay, time spent, eraser/undo behaviour, follow‑up
answers, AI preliminary summaries, and the chat transcript — then write the **final
interpretation**, which only a trained human provides.
