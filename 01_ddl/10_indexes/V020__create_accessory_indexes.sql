-- GET /accessories: newest first.
CREATE INDEX idx_accessory_created ON products.accessory (created_at DESC, id DESC);

-- GET /accessories?lowStock=true: only the accessories that need restocking.
CREATE INDEX idx_accessory_low_stock ON products.accessory (stock) WHERE stock <= min_stock;

-- Filter by category.
CREATE INDEX idx_accessory_category ON products.accessory (category);
