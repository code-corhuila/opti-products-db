-- accessory_reservation: units of accessory stock held for a sale. Same shape as lens_reservation
-- and stock_reservation (frames): its own table, FK to products.accessory, reusing the same
-- product-agnostic Reservation domain class and ReservationRepository port in products-api.
CREATE TABLE products.accessory_reservation (
    id               uuid        NOT NULL,
    accessory_id     uuid        NOT NULL,
    sku              text        NOT NULL,
    description      text        NOT NULL,
    quantity         integer     NOT NULL,
    unit_price_cents bigint      NOT NULL,
    reference        text        NOT NULL,
    status           text        NOT NULL DEFAULT 'RESERVED',
    created_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_accessory_reservation PRIMARY KEY (id),
    CONSTRAINT fk_accessory_reservation_accessory FOREIGN KEY (accessory_id)
        REFERENCES products.accessory (id) ON DELETE RESTRICT,
    CONSTRAINT chk_accessory_reservation_quantity CHECK (quantity BETWEEN 1 AND 1000000),
    CONSTRAINT chk_accessory_reservation_price CHECK (unit_price_cents >= 0),
    CONSTRAINT chk_accessory_reservation_reference CHECK (char_length(reference) BETWEEN 1 AND 64),
    CONSTRAINT chk_accessory_reservation_status CHECK (status IN ('RESERVED', 'RELEASED'))
);

COMMENT ON TABLE products.accessory_reservation IS 'Stock held for a sale (for example by a saga). RELEASED gives the units back.';
COMMENT ON COLUMN products.accessory_reservation.reference IS 'Caller reference, for example the saga id, to trace the reservation.';
