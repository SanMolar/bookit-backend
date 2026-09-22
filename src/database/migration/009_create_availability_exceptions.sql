CREATE TABLE public.availability_exceptions(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL REFERENCES public.providers(id) ON DELETE CASCADE,
    exception_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    exception_type VARCHAR(20) NOT NULL CHECK(exception_type IN ('BLOCKED', 'AVAILABLE')),
    is_all_day BOOLEAN NOT NULL DEFAULT FALSE,
    reason TEXT,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK ( (is_all_day = TRUE AND exception_type = 'BLOCKED' AND start_time IS NULL AND end_time IS NULL) OR
            (is_all_day = FALSE AND start_time IS NOT NULL AND end_time IS NOT NULL AND end_time > start_time)
    )
);

ALTER TABLE public.availability_exceptions ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.availability_exceptions FROM anon, authenticated;