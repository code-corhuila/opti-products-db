-- products.lens follows the same read/write split as products.frame. It is granted here, not by
-- the blanket "ALL TABLES IN SCHEMA" in V011, because that grant only covers tables that already
-- existed when it ran.
GRANT SELECT ON products.lens TO products_reader;
GRANT SELECT, INSERT, UPDATE ON products.lens TO products_writer;
