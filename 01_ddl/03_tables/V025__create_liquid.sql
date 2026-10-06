-- liquid: lens cleaner, contact lens solution and the like, sold by container size (HU-25).
-- volume_ml is the container size in millilitres. Money is stored in cents (bigint).
CREATE TABLE products.liquid (
    id               uuid        NOT NULL,
    sku              text        NOT NULL,
    brand            text        NOT NULL,
    volume_ml        integer     NOT NULL,
    cost_cents       bigint      NOT NULL,
    sale_price_cents bigint      NOT NULL,
    stock            integer     NOT NULL DEFAULT 0,
    min_stock        integer     NOT NULL DEFAULT 0,
    status           text        NOT NULL DEFAULT 'ACTIVE',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_liquid PRIMARY KEY (id),
    CONSTRAINT uq_liquid_sku UNIQUE (sku),
    CONSTRAINT chk_liquid_sku CHECK (sku ~ '^[A-Za-z0-9][A-Za-z0-9._-]{2,59}$'),
    CONSTRAINT chk_liquid_brand CHECK (char_length(brand) BETWEEN 2 AND 80),
    CONSTRAINT chk_liquid_volume CHECK (volume_ml BETWEEN 1 AND 5000),
    CONSTRAINT chk_liquid_cost CHECK (cost_cents BETWEEN 0 AND 100000000000),
    CONSTRAINT chk_liquid_price CHECK (sale_price_cents BETWEEN 0 AND 100000000000 AND sale_price_cents >= cost_cents),
    CONSTRAINT chk_liquid_stock CHECK (stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_liquid_min_stock CHECK (min_stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_liquid_status CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

COMMENT ON TABLE products.liquid IS 'A liquid of the catalogue with its stock. Invariants: stock >= 0 and sale price >= cost.';
COMMENT ON COLUMN products.liquid.volume_ml IS 'Container size in millilitres.';
COMMENT ON COLUMN products.liquid.cost_cents IS 'Purchase cost in cents (minor units).';
COMMENT ON COLUMN products.liquid.sale_price_cents IS 'Sale price in cents (minor units); never below the cost.';
COMMENT ON COLUMN products.liquid.min_stock IS 'At or below this stock the liquid is listed as low stock (lowStock=true).';
