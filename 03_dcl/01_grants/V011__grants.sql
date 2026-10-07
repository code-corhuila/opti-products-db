GRANT USAGE ON SCHEMA products TO products_reader, products_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA products TO products_reader;
GRANT SELECT, INSERT, UPDATE ON products.frame, products.stock_reservation TO products_writer;
GRANT SELECT, INSERT ON products.stock_movement, products.idempotency_key TO products_writer;
