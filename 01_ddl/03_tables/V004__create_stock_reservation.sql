-- stock_reservation: units held for a sale. It keeps a snapshot of the frame so the sale is priced here.
CREATE TABLE products.stock_reservation (
    id               uuid        NOT NULL,
    frame_id         uuid        NOT NULL,
    sku              text        NOT NULL,
    description      text        NOT NULL,
    quantity         integer     NOT NULL,
    unit_price_cents bigint      NOT NULL,
    reference        text        NOT NULL,
    status           text        NOT NULL DEFAULT 'RESERVED',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_stock_reservation PRIMARY KEY (id),
    CONSTRAINT chk_stock_reservation_quantity CHECK (quantity BETWEEN 1 AND 1000000),
    CONSTRAINT chk_stock_reservation_price CHECK (unit_price_cents >= 0),
    CONSTRAINT chk_stock_reservation_reference CHECK (char_length(reference) BETWEEN 1 AND 64),
    CONSTRAINT chk_stock_reservation_status CHECK (status IN ('RESERVED', 'RELEASED'))
);

COMMENT ON TABLE products.stock_reservation IS 'Stock held for a sale (for example by a saga). RELEASED gives the units back.';
COMMENT ON COLUMN products.stock_reservation.reference IS 'Caller reference, for example the saga id, to trace the reservation.';
