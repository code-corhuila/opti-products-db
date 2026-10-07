-- liquid_reservation: units of liquid stock held for a sale. Same shape as lens_reservation and
-- accessory_reservation: its own table, FK to products.liquid, reusing the same product-agnostic
-- Reservation domain class and ReservationRepository port in products-api.
CREATE TABLE products.liquid_reservation (
    id               uuid        NOT NULL,
    liquid_id        uuid        NOT NULL,
    sku              text        NOT NULL,
    description      text        NOT NULL,
    quantity         integer     NOT NULL,
    unit_price_cents bigint      NOT NULL,
    reference        text        NOT NULL,
    status           text        NOT NULL DEFAULT 'RESERVED',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_liquid_reservation PRIMARY KEY (id),
    CONSTRAINT fk_liquid_reservation_liquid FOREIGN KEY (liquid_id)
        REFERENCES products.liquid (id) ON DELETE RESTRICT,
    CONSTRAINT chk_liquid_reservation_quantity CHECK (quantity BETWEEN 1 AND 1000000),
    CONSTRAINT chk_liquid_reservation_price CHECK (unit_price_cents >= 0),
    CONSTRAINT chk_liquid_reservation_reference CHECK (char_length(reference) BETWEEN 1 AND 64),
    CONSTRAINT chk_liquid_reservation_status CHECK (status IN ('RESERVED', 'RELEASED'))
);

COMMENT ON TABLE products.liquid_reservation IS 'Stock held for a sale (for example by a saga). RELEASED gives the units back.';
COMMENT ON COLUMN products.liquid_reservation.reference IS 'Caller reference, for example the saga id, to trace the reservation.';
