-- GET /lenses: newest first.
CREATE INDEX idx_lens_created ON products.lens (created_at DESC, id DESC);

-- GET /lenses?lowStock=true: only the lenses that need restocking.
CREATE INDEX idx_lens_low_stock ON products.lens (stock) WHERE stock <= min_stock;

-- Search by sku or brand.
CREATE INDEX idx_lens_brand ON products.lens (lower(brand));
