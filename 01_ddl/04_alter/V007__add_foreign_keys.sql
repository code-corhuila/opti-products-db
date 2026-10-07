-- Foreign keys live here, after every table exists, so table order never matters.
-- History is kept: a frame with reservations or movements cannot be deleted (RESTRICT).
ALTER TABLE products.stock_reservation
    ADD CONSTRAINT fk_stock_reservation_frame
    FOREIGN KEY (frame_id) REFERENCES products.frame (id) ON DELETE RESTRICT;

ALTER TABLE products.stock_movement
    ADD CONSTRAINT fk_stock_movement_frame
    FOREIGN KEY (frame_id) REFERENCES products.frame (id) ON DELETE RESTRICT;
