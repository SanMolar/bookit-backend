CREATE TABLE public.appointments(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL REFERENCES public.businesses(id) ON DELETE CASCADE,
    client_id UUID NOT NULL REFERENCES public.clients(id) ON DELETE RESTRICT,
    provider_id UUID NOT NULL REFERENCES public.providers(id) ON DELETE RESTRICT,
    service_id UUID NOT NULL REFERENCES public.services(id) ON DELETE RESTRICT,
    starts_at TIMESTAMPTZ NOT NULL,
    ends_at TIMESTAMPTZ NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED' CHECK (status IN ('CONFIRMED', 'CANCELLED', 'COMPLETED', 'NO_SHOW')),
    price_at_booking NUMERIC(10, 2) CHECK(price_at_booking >= 0),
    management_token_hash TEXT NOT NULL UNIQUE,
    management_token_expires_at TIMESTAMPTZ NOT NULL,
    created_by_user_id UUID REFERENCES public.users(id) ON DELETE SET NULL,
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (ends_at > starts_at),
    CHECK (
    (status = 'COMPLETED' AND completed_at IS NOT NULL)
    OR
    (status <> 'COMPLETED' AND completed_at IS NULL)
    )
);

ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.appointments FROM anon, authenticated;