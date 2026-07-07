CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)
SELECT
    uuid_generate_v4(),
    uuid_generate_v4(),
    'HOTEL-' || ((g % 10) + 1),
    (ARRAY['Delhi','Mumbai','Bangalore','Chennai','Hyderabad'])[floor(random()*5 + 1)],
    CURRENT_DATE + (g % 30),
    CURRENT_DATE + (g % 30) + 2,
    round((1000 + random()*9000)::numeric,2),
    (ARRAY['BOOKED','CONFIRMED','CANCELLED'])[floor(random()*3 + 1)],
    NOW() - (random() * interval '30 days')
FROM generate_series(1,100) g;

INSERT INTO booking_events (
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    'BOOKING_CREATED',
    jsonb_build_object('source','seed-script'),
    created_at
FROM hotel_bookings
LIMIT 50;