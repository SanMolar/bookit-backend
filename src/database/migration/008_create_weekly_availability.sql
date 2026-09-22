CREATE TABLE public.weekly_availability(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL REFERENCES public.providers(id) ON DELETE CASCADE,
    day_of_week SMALLINT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (end_time > start_time),
    UNIQUE (provider_id, day_of_week, start_time, end_time)
);

ALTER TABLE public.weekly_availability ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.weekly_availability FROM anon, authenticated;