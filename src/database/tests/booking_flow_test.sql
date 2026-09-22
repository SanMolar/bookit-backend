BEGIN;

INSERT INTO public.users (email, password_hash, full_name)
VALUES ('test@example.com', 'hashed_password', 'Test User') RETURNING id;

INSERT INTO public.businesses (name, slug, timezone)
VALUES ('test business', 'test-business', 'America/Monterrey') RETURNING id;

INSERT INTO public.business_members (user_id, business_id, role)
VALUES (
    (SELECT id FROM public.users WHERE email = 'test@example.com'),
    (SELECT id FROM public.businesses WHERE slug = 'test-business'),
    'OWNER'
);

INSERT INTO public.clients(business_id, full_name, email)
VALUES (
    (SELECT id FROM public.businesses WHERE slug = 'test-business'),
    'Cliente de prueba',
    'client-test@example.com'
);

INSERT INTO public.providers(business_id, user_id, full_name, job_title)
VALUES (
    (SELECT id FROM public.businesses WHERE slug = 'test-business'),
    (SELECT id FROM public.users WHERE email = 'test@example.com'),
    'Test Provider',
    'Barber'
);

INSERT INTO public.services(business_id, name, description,  duration_minutes, price)
VALUES(
    (SELECT id FROM public.businesses WHERE slug = 'test-business'),
    'test haircut',
    'test haircut description',
    30,
    25.00
);

INSERT INTO public.provider_services (provider_id, service_id)
VALUES (
    (
        SELECT id
        FROM public.providers
        WHERE user_id = (
            SELECT id FROM public.users WHERE email = 'test@example.com'
        )
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    (
        SELECT id
        FROM public.services
        WHERE name = 'test haircut'
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    )
);

INSERT INTO public.weekly_availability (provider_id, day_of_week, start_time, end_time)
VALUES (
     (
        SELECT id
        FROM public.providers
        WHERE user_id = (
            SELECT id FROM public.users WHERE email = 'test@example.com'
        )
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    1,
    '09:00:00',
    '17:00:00'
);

INSERT INTO public.availability_exceptions (provider_id, exception_date, start_time, end_time, exception_type, reason)
VALUES (
      (
        SELECT id
        FROM public.providers
        WHERE user_id = (
            SELECT id FROM public.users WHERE email = 'test@example.com'
        )
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    '2030-01-07',
    '12:00',
    '13:00',
    'BLOCKED',
    'DESCANSO DE PRUEBA'
);

INSERT INTO public.appointments (
    business_id,
    client_id,
    provider_id,
    service_id,
    starts_at,
    ends_at,
    price_at_booking,
    management_token_hash,
    management_token_expires_at,
    created_by_user_id
)
VALUES (
    (SELECT id FROM public.businesses WHERE slug = 'test-business'),
    (
        SELECT id
        FROM public.clients
        WHERE email = 'client-test@example.com'
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    (
        SELECT id
        FROM public.providers
        WHERE user_id = (
            SELECT id FROM public.users WHERE email = 'test@example.com'
        )
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    (
        SELECT id
        FROM public.services
        WHERE name = 'test haircut'
        AND business_id = (
            SELECT id FROM public.businesses WHERE slug = 'test-business'
        )
    ),
    '2030-01-07 10:00:00-06',
    '2030-01-07 10:30:00-06',
    25.00,
    'test_management_token_hash',
    '2030-01-07 10:00:00-06',
    (SELECT id FROM public.users WHERE email = 'test@example.com')
);

SELECT 
    businesses.name AS business_name,
    clients.full_name AS client_name,
    providers.full_name AS provider_name,
    services.name AS service_name,
    users.full_name AS created_by,
    appointments.starts_at,
    appointments.ends_at,
    appointments.status
FROM public.appointments

JOIN public.businesses
ON appointments.business_id = businesses.id

JOIN public.clients
ON appointments.client_id = clients.id

JOIN public.providers
ON appointments.provider_id = providers.id

JOIN public.services
ON appointments.service_id = services.id

JOIN public.users
ON appointments.created_by_user_id = users.id

WHERE appointments.management_token_hash = 'test_management_token_hash';

ROLLBACK;