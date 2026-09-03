CREATE INDEX idx_business_members_user_id ON public.business_members (user_id);

CREATE INDEX idx_clients_business_id ON public.clients(business_id);

CREATE INDEX idx_provider_services_service_id ON public.provider_services(service_id);

CREATE INDEX idx_availability_exceptions_provider_date ON public.availability_exceptions(provider_id, exception_date);

CREATE INDEX idx_appointments_business_starts_at ON public.appointments(business_id, starts_at);

CREATE INDEX idx_appointments_provider_starts_at ON public.appointments(provider_id, starts_at);

CREATE INDEX idx_appointments_client_starts_at ON public.appointments(client_id, starts_at);

CREATE INDEX idx_appointments_service_id ON public.appointments(service_id);

