CREATE TABLE public.providers(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL REFERENCES public.businesses(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.users(id) ON DELETE SET NULL,
    full_name VARCHAR(120) NOT NULL,
    job_title VARCHAR(80),
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (business_id, user_id)
);

ALTER TABLE public.providers ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.providers FROM anon, authenticated;