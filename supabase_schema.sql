-- ============================================================
-- PHC Resident Doctors Activity Tracker — Supabase Schema
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- 1. POSTINGS / DUTY ROSTER
create table if not exists postings (
  id          text primary key,
  doctor      text not null,
  month       text not null,
  year        text not null,
  station     text not null,
  rs          text not null default 'pending',   -- 'pending' | 'completed'
  con         text default '',                    -- signing consultant
  notes       text default '',
  created_at  timestamptz default now()
);

-- 2. LEAVE SCHEDULE
create table if not exists leave_records (
  id          text primary key,
  name        text not null,
  type        text not null,
  start_date  date not null,
  end_date    date not null,
  dur         text default '',
  rel         text default '',                    -- reliever
  notes       text default '',
  created_at  timestamptz default now()
);

-- 3. ACTIVITIES (journals, seminars, research, other)
create table if not exists activities (
  id          text primary key,
  kind        text not null,                      -- 'journal'|'seminar'|'research'|'other'
  doctor      text not null,
  title       text not null,
  date        date,
  year        text default '',
  venue       text default '',
  extra       text default '',                    -- discussant / chairperson
  pubtype     text default '',                    -- for research
  jn          text default '',                    -- journal name
  category    text default '',                    -- for other
  status      text default 'Scheduled',
  notes       text default '',
  created_at  timestamptz default now()
);

-- ============================================================
-- Enable Row Level Security (RLS) — open read/write for now
-- Tighten this once you add authentication
-- ============================================================
alter table postings      enable row level security;
alter table leave_records enable row level security;
alter table activities    enable row level security;

-- Allow all operations (change to authenticated-only later)
create policy "public_all_postings"      on postings      for all using (true) with check (true);
create policy "public_all_leave"         on leave_records for all using (true) with check (true);
create policy "public_all_activities"    on activities    for all using (true) with check (true);

-- ============================================================
-- Optional: Indexes for faster queries
-- ============================================================
create index if not exists idx_postings_year   on postings(year);
create index if not exists idx_postings_doctor on postings(doctor);
create index if not exists idx_leave_start     on leave_records(start_date);
create index if not exists idx_acts_kind       on activities(kind);
create index if not exists idx_acts_doctor     on activities(doctor);
create index if not exists idx_acts_year       on activities(year);
