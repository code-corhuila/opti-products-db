-- frame: the catalogue item and its current stock. Money is stored in cents (bigint), never floating point.
CREATE TABLE products.frame (
    id                uuid        NOT NULL,
    sku               text        NOT NULL,
    brand             text        NOT NULL,
    model             text        NOT NULL,
    color             text,
    material          text,
    gender            text,
    cost_cents        bigint      NOT NULL,
    sale_price_cents  bigint      NOT NULL,
    stock             integer     NOT NULL DEFAULT 0,
    min_stock         integer     NOT NULL DEFAULT 0,
    location          text,
    supplier          text,
    status            text        NOT NULL DEFAULT 'ACTIVE',
    created_at        timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_frame PRIMARY KEY (id),
    CONSTRAINT uq_frame_sku UNIQUE (sku),
    CONSTRAINT chk_frame_sku CHECK (sku ~ '^[A-Za-z0-9][A-Za-z0-9._-]{2,59}$'),
    CONSTRAINT chk_frame_brand CHECK (char_length(brand) BETWEEN 2 AND 80),
    CONSTRAINT chk_frame_model CHECK (char_length(model) BETWEEN 1 AND 80),
    CONSTRAINT chk_frame_cost CHECK (cost_cents BETWEEN 0 AND 100000000000),
    CONSTRAINT chk_frame_price CHECK (sale_price_cents BETWEEN 0 AND 100000000000 AND sale_price_cents >= cost_cents),
    CONSTRAINT chk_frame_stock CHECK (stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_frame_min_stock CHECK (min_stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_frame_status CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

COMMENT ON TABLE products.frame IS 'A frame of the catalogue with its stock. Invariants: stock >= 0 and sale price >= cost.';
COMMENT ON COLUMN products.frame.cost_cents IS 'Purchase cost in cents (minor units).';
COMMENT ON COLUMN products.frame.sale_price_cents IS 'Sale price in cents (minor units); never below the cost.';
COMMENT ON COLUMN products.frame.min_stock IS 'At or below this stock the frame is listed as low stock (lowStock=true).';
