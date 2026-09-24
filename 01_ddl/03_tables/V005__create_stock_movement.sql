-- stock_movement: append-only ledger of every change of stock (also the base for future purchase reports).
CREATE TABLE products.stock_movement (
    id            uuid        NOT NULL,
    frame_id      uuid        NOT NULL,
    movement_type text        NOT NULL,
    quantity      integer     NOT NULL,
    reference     text,
    reason        text,
    created_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_stock_movement PRIMARY KEY (id),
    CONSTRAINT chk_stock_movement_type CHECK (movement_type IN ('ENTRY', 'EXIT', 'RETURN')),
    CONSTRAINT chk_stock_movement_quantity CHECK (quantity BETWEEN 1 AND 1000000)
);

COMMENT ON TABLE products.stock_movement IS 'Append-only stock ledger: ENTRY (supplier), EXIT (reservation), RETURN (released reservation).';
