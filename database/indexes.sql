CREATE INDEX idx_hotel_bookings_city_created
ON hotel_bookings (city, created_at);

CREATE INDEX idx_hotel_bookings_org_status
ON hotel_bookings (org_id, status);

CREATE INDEX idx_booking_events_booking_id
ON booking_events (booking_id);

