-- accessory: cases, cleaning cloths, straps and the like (HU-25). category is free text, not a
-- closed enum: the store defines its own accessory categories and that list keeps growing, unlike
-- lens type or frame gender which are fixed by the business. brand is optional (not every
-- accessory is branded). Money is stored in cents (bigint), never floating point.
CREATE TABLE products.accessory (
    id               uuid        NOT NULL,
    sku              text        NOT NULL,
    brand            text,
    category         text        NOT NULL,
    cost_cents       bigint      NOT NULL,
    sale_price_cents bigint      NOT NULL,
    stock            integer     NOT NULL DEFAULT 0,
    min_stock        integer     NOT NULL DEFAULT 0,
    status           text        NOT NULL DEFAULT 'ACTIVE',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_accessory PRIMARY KEY (id),
    CONSTRAINT uq_accessory_sku UNIQUE (sku),
    CONSTRAINT chk_accessory_sku CHECK (sku ~ '^[A-Za-z0-9][A-Za-z0-9._-]{2,59}$'),
    CONSTRAINT chk_accessory_brand CHECK (brand IS NULL OR char_length(brand) BETWEEN 2 AND 80),
    CONSTRAINT chk_accessory_category CHECK (char_length(category) BETWEEN 2 AND 60),
    CONSTRAINT chk_accessory_cost CHECK (cost_cents BETWEEN 0 AND 100000000000),
    CONSTRAINT chk_accessory_price CHECK (sale_price_cents BETWEEN 0 AND 100000000000 AND sale_price_cents >= cost_cents),
    CONSTRAINT chk_accessory_stock CHECK (stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_accessory_min_stock CHECK (min_stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_accessory_status CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

COMMENT ON TABLE products.accessory IS 'An accessory of the catalogue with its stock. Invariants: stock >= 0 and sale price >= cost.';
COMMENT ON COLUMN products.accessory.category IS 'Free text, store-defined (e.g. Estuche, Paño de limpieza, Cordón).';
COMMENT ON COLUMN products.accessory.cost_cents IS 'Purchase cost in cents (minor units).';
COMMENT ON COLUMN products.accessory.sale_price_cents IS 'Sale price in cents (minor units); never below the cost.';
COMMENT ON COLUMN products.accessory.min_stock IS 'At or below this stock the accessory is listed as low stock (lowStock=true).';
