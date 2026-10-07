-- Regression check against a migrated PostgreSQL database. Leaves no persisted test rows.
BEGIN;
SET LOCAL search_path TO products;
DO $$
DECLARE operation text;
BEGIN
    FOREACH operation IN ARRAY ARRAY[
        'FRAME', 'STOCK_ENTRY', 'RESERVATION',
        'LENS', 'LENS_STOCK_ENTRY', 'LENS_RESERVATION',
        'ACCESSORY', 'ACCESSORY_STOCK_ENTRY', 'ACCESSORY_RESERVATION',
        'LIQUID', 'LIQUID_STOCK_ENTRY', 'LIQUID_RESERVATION'
    ] LOOP
        INSERT INTO idempotency_key (key, resource_type, resource_id)
        VALUES ('contract-' || gen_random_uuid(), operation, gen_random_uuid());
    END LOOP;
END $$;
ROLLBACK;
