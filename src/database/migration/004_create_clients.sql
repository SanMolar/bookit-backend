
CREATE TABLE public.clients(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL REFERENCES public.businesses(id) ON DELETE CASCADE,
    full_name VARCHAR(120) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (phone IS NOT NULL OR email IS NOT NULL)
);

ALTER TABLE public.clients ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.clients  FROM anon, authenticated;