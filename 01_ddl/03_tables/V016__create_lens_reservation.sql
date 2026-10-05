-- lens_reservation: units of lens stock held for a sale. It keeps a snapshot of the lens (sku,
-- description, price) so the sale is priced here. Deliberately NOT shared with stock_reservation
-- (frames): frame's existing table, repository and sales-api contract stay untouched, and each
-- product type gets its own reservation ledger. The domain layer still reuses the same
-- product-agnostic Reservation class and ReservationRepository port as frames (see products-api).
CREATE TABLE products.lens_reservation (
    id               uuid        NOT NULL,
    lens_id          uuid        NOT NULL,
    sku              text        NOT NULL,
    description      text        NOT NULL,
    quantity         integer     NOT NULL,
    unit_price_cents bigint      NOT NULL,
    reference        text        NOT NULL,
    status           text        NOT NULL DEFAULT 'RESERVED',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_lens_reservation PRIMARY KEY (id),
    CONSTRAINT fk_lens_reservation_lens FOREIGN KEY (lens_id) REFERENCES products.lens (id) ON DELETE RESTRICT,
    CONSTRAINT chk_lens_reservation_quantity CHECK (quantity BETWEEN 1 AND 1000000),
    CONSTRAINT chk_lens_reservation_price CHECK (unit_price_cents >= 0),
    CONSTRAINT chk_lens_reservation_reference CHECK (char_length(reference) BETWEEN 1 AND 64),
    CONSTRAINT chk_lens_reservation_status CHECK (status IN ('RESERVED', 'RELEASED'))
);

COMMENT ON TABLE products.lens_reservation IS 'Stock held for a sale (for example by a saga). RELEASED gives the units back.';
COMMENT ON COLUMN products.lens_reservation.reference IS 'Caller reference, for example the saga id, to trace the reservation.';
