-- lens: the catalogue item and its current stock, distinct from frame. Money is stored in cents
-- (bigint), never floating point. refractive_index_x100 is the refractive index times 100
-- (e.g. 150 for 1.50), since the domain only needs two decimal places.
CREATE TABLE products.lens (
    id                      uuid        NOT NULL,
    sku                     text        NOT NULL,
    brand                   text        NOT NULL,
    lens_type               text        NOT NULL,
    material                text,
    coating                 text,
    refractive_index_x100   integer,
    cost_cents              bigint      NOT NULL,
    sale_price_cents        bigint      NOT NULL,
    stock                   integer     NOT NULL DEFAULT 0,
    min_stock               integer     NOT NULL DEFAULT 0,
    status                  text        NOT NULL DEFAULT 'ACTIVE',
    created_at              timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_lens PRIMARY KEY (id),
    CONSTRAINT uq_lens_sku UNIQUE (sku),
    CONSTRAINT chk_lens_sku CHECK (sku ~ '^[A-Za-z0-9][A-Za-z0-9._-]{2,59}$'),
    CONSTRAINT chk_lens_brand CHECK (char_length(brand) BETWEEN 2 AND 80),
    CONSTRAINT chk_lens_type CHECK (lens_type IN ('MONOFOCAL', 'BIFOCAL', 'PROGRESSIVE', 'OCCUPATIONAL')),
    CONSTRAINT chk_lens_refractive_index CHECK (refractive_index_x100 IS NULL OR refractive_index_x100 BETWEEN 100 AND 200),
    CONSTRAINT chk_lens_cost CHECK (cost_cents BETWEEN 0 AND 100000000000),
    CONSTRAINT chk_lens_price CHECK (sale_price_cents BETWEEN 0 AND 100000000000 AND sale_price_cents >= cost_cents),
    CONSTRAINT chk_lens_stock CHECK (stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_lens_min_stock CHECK (min_stock BETWEEN 0 AND 1000000),
    CONSTRAINT chk_lens_status CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

COMMENT ON TABLE products.lens IS 'A lens of the catalogue with its stock. Invariants: stock >= 0 and sale price >= cost.';
COMMENT ON COLUMN products.lens.refractive_index_x100 IS 'Refractive index times 100 (e.g. 150 = 1.50).';
COMMENT ON COLUMN products.lens.cost_cents IS 'Purchase cost in cents (minor units).';
COMMENT ON COLUMN products.lens.sale_price_cents IS 'Sale price in cents (minor units); never below the cost.';
COMMENT ON COLUMN products.lens.min_stock IS 'At or below this stock the lens is listed as low stock (lowStock=true).';
