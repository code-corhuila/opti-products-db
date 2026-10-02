-- Plain CREATE INDEX is fine here: the tables were created in this same release and are empty.
-- Any later index on a table with data goes in its own migration with CREATE INDEX CONCURRENTLY.

-- fk_stock_reservation_frame and fk_stock_movement_frame: every foreign key column has its index.
CREATE INDEX idx_stock_reservation_frame ON products.stock_reservation (frame_id);
CREATE INDEX idx_stock_movement_frame_created ON products.stock_movement (frame_id, created_at DESC, id DESC);

-- GET /frames: newest first.
CREATE INDEX idx_frame_created ON products.frame (created_at DESC, id DESC);

-- GET /frames?lowStock=true (HU-06): only the frames that need restocking.
CREATE INDEX idx_frame_low_stock ON products.frame (stock) WHERE stock <= min_stock;

-- Search by brand or model.
CREATE INDEX idx_frame_brand_model ON products.frame (lower(brand), lower(model));
