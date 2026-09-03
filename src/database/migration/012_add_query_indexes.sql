CREATE INDEX
idx_business_members_user_id
ON public.business_members
(user_id);

idx_clients_business_id
ON public.clients
(business_id);