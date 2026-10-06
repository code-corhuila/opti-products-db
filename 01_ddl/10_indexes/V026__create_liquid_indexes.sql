-- GET /liquids: newest first.
CREATE INDEX idx_liquid_created ON products.liquid (created_at DESC, id DESC);

-- GET /liquids?lowStock=true: only the liquids that need restocking.
CREATE INDEX idx_liquid_low_stock ON products.liquid (stock) WHERE stock <= min_stock;

-- Search by sku or brand.
CREATE INDEX idx_liquid_brand ON products.liquid (lower(brand));
