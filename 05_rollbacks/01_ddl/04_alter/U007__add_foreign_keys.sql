ALTER TABLE IF EXISTS products.stock_reservation DROP CONSTRAINT IF EXISTS fk_stock_reservation_frame;
ALTER TABLE IF EXISTS products.stock_movement DROP CONSTRAINT IF EXISTS fk_stock_movement_frame;
