-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Idempotent: running it again changes nothing but descriptive columns. Prices in cents.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO products.lens (id, sku, brand, lens_type, material, coating, refractive_index_x100, cost_cents, sale_price_cents, stock, min_stock)
        VALUES
            ('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee', 'LNS-MONO-150', 'Essilor', 'MONOFOCAL', 'CR-39', 'Anti-reflejo', 150, 8000000, 15000000, 20, 5),
            ('ffffffff-ffff-4fff-8fff-ffffffffffff', 'LNS-PROG-167', 'Zeiss', 'PROGRESSIVE', 'Policarbonato', 'Anti-reflejo + Filtro azul', 167, 22000000, 42000000, 6, 2),
            ('11111111-1111-4111-8111-111111111111', 'LNS-BIFO-159', 'Hoya', 'BIFOCAL', 'CR-39', 'Anti-rayones', 159, 12000000, 24000000, 0, 2)
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            lens_type = EXCLUDED.lens_type,
            material = EXCLUDED.material,
            coating = EXCLUDED.coating,
            refractive_index_x100 = EXCLUDED.refractive_index_x100;
    END IF;
END
$seed$;
