-- Extend the existing catalog key contract without changing stored keys or products.
ALTER TABLE products.idempotency_key
    DROP CONSTRAINT chk_idempotency_key_type,
    ADD CONSTRAINT chk_idempotency_key_type
        CHECK (resource_type IN ('FRAME', 'LENS', 'ACCESSORY', 'LIQUID', 'STOCK_ENTRY', 'RESERVATION'));
