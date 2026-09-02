
CREATE TABLE public.business_members(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    business_id UUID NOT NULL REFERENCES public.businesses(id) ON DELETE CASCADE,
    UNIQUE(business_id, user_id),
    role VARCHAR(20) NOT NULL CHECK(role in('OWNER', 'RECEPTIONIST')),
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.business_members ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.business_members FROM anon, authenticated;