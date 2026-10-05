-- Lookups by lens, e.g. to list a lens's history or to lock in an ordered way.
CREATE INDEX idx_lens_reservation_lens ON products.lens_reservation (lens_id);
