
CREATE TABLE public.businesses(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(120) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    timezone VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


ALTER TABLE public.businesses ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.businesses FROM anon, authenticated;