CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE public.appointments
ADD CONSTRAINT appointments_no_overlapping_confirmed
EXCLUDE USING gist (
provider_id WITH =, tstzrange(starts_at, ends_at, '[)') WITH &&)
WHERE (status = 'CONFIRMED'
);