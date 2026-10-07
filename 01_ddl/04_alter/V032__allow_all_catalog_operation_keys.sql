-- Every catalog supports registration, stock entries and reservations.
ALTER TABLE products.idempotency_key
    DROP CONSTRAINT chk_idempotency_key_type,
    ADD CONSTRAINT chk_idempotency_key_type CHECK (resource_type IN (
        'FRAME', 'STOCK_ENTRY', 'RESERVATION',
        'LENS', 'LENS_STOCK_ENTRY', 'LENS_RESERVATION',
        'ACCESSORY', 'ACCESSORY_STOCK_ENTRY', 'ACCESSORY_RESERVATION',
        'LIQUID', 'LIQUID_STOCK_ENTRY', 'LIQUID_RESERVATION'
    ));
