-- House · Tree · Person — Reflection Test
-- PostgreSQL / Supabase schema
-- Privacy: no real names. Anonymous UUIDs only. Store images in object storage;
-- keep only storage keys / URLs here.

create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------------
-- participants
-- ---------------------------------------------------------------------------
create table if not exists participants (
  participant_id    uuid primary key default gen_random_uuid(),
  created_at        timestamptz not null default now(),
  language          text,                       -- 'en' | 'ko'
  age_range         text,                       -- e.g. '25-34' (or use birth_year_month)
  birth_year_month  text,
  gender            text,
  mood_checkin      text,
  drawing_comfort   text,
  consent_version   text,
  consent_accepted  boolean not null default false,
  research_opt_in   boolean not null default false
);

-- ---------------------------------------------------------------------------
-- sessions
-- ---------------------------------------------------------------------------
create table if not exists sessions (
  session_id      uuid primary key default gen_random_uuid(),
  participant_id  uuid references participants(participant_id) on delete cascade,
  mode            text,                          -- 'draw' | 'image_choice' | 'hybrid'
  started_at      timestamptz not null default now(),
  completed_at    timestamptz,
  locale          text,
  status          text default 'in_progress',    -- 'in_progress' | 'completed' | 'abandoned'
  user_agent      text
);

-- ---------------------------------------------------------------------------
-- drawings
-- ---------------------------------------------------------------------------
create table if not exists drawings (
  drawing_id      uuid primary key default gen_random_uuid(),
  session_id      uuid references sessions(session_id) on delete cascade,
  drawing_type    text not null,                 -- 'house' | 'tree' | 'person'
  image_url       text,                          -- storage key/URL of final PNG
  stroke_json     jsonb,                         -- stroke-level capture (see docs/data-schemas.md)
  duration_seconds integer,
  canvas_width    integer,
  canvas_height   integer,
  undo_count      integer default 0,
  eraser_count    integer default 0,
  created_at      timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- image_selections
-- ---------------------------------------------------------------------------
create table if not exists image_selections (
  selection_id            uuid primary key default gen_random_uuid(),
  session_id              uuid references sessions(session_id) on delete cascade,
  category                text not null,         -- 'house' | 'tree' | 'person'
  source                  text not null,         -- 'curated' | 'unsplash' | 'upload'
  image_url               text,
  thumbnail_url           text,
  unsplash_photo_id       text,
  photographer_name       text,
  photographer_profile_url text,
  curated_category_tags   text[],
  selection_type          text default 'primary',-- 'primary' | 'most_drawn_to' | 'least_drawn_to'
  time_to_select_seconds  integer,
  selected_reason         text,
  selected_at             timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- followup_answers
-- ---------------------------------------------------------------------------
create table if not exists followup_answers (
  answer_id     uuid primary key default gen_random_uuid(),
  session_id    uuid references sessions(session_id) on delete cascade,
  item_type     text,                            -- 'drawing' | 'image_selection' | 'hybrid_pair'
  category      text,                            -- 'house' | 'tree' | 'person'
  question_key  text,
  answer_text   text,
  created_at    timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- ai_reflections  (preliminary, for expert review — never a final interpretation)
-- ---------------------------------------------------------------------------
create table if not exists ai_reflections (
  reflection_id        uuid primary key default gen_random_uuid(),
  session_id           uuid references sessions(session_id) on delete cascade,
  model_name           text,
  prompt_version       text,
  visual_observations  jsonb,
  symbolic_reflection  jsonb,
  user_words_summary   text,
  reflection_questions jsonb,
  action_step          text,
  safety_disclaimer    text,
  expert_reviewed      boolean default false,
  expert_notes         text,
  expert_interpretation text,
  created_at           timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- chat_messages
-- ---------------------------------------------------------------------------
create table if not exists chat_messages (
  message_id  uuid primary key default gen_random_uuid(),
  session_id  uuid references sessions(session_id) on delete cascade,
  role        text not null,                     -- 'user' | 'assistant' | 'system'
  content     text not null,
  created_at  timestamptz not null default now()
);

create index if not exists idx_sessions_participant on sessions(participant_id);
create index if not exists idx_drawings_session on drawings(session_id);
create index if not exists idx_selections_session on image_selections(session_id);
create index if not exists idx_answers_session on followup_answers(session_id);
create index if not exists idx_chat_session on chat_messages(session_id);
