-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Idempotent. Prices in cents. Fixed ids so sales demo orders can reference them.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO products.lens (id, sku, brand, lens_type, material, coating, refractive_index_x100, cost_cents, sale_price_cents, stock, min_stock)
        VALUES
            ('f1111111-1111-4111-8111-111111111111', 'ESS-VAR-156', 'Essilor', 'PROGRESSIVE', 'Organic', 'Antireflejo + Blue UV', 156, 45000000, 89000000, 20, 5),
            ('f2222222-2222-4222-8222-222222222222', 'ESS-MONO-150', 'Essilor', 'MONOFOCAL', 'Organic', 'Antireflejo', 150, 18000000, 35000000, 40, 8),
            ('f3333333-3333-4333-8333-333333333333', 'HOYA-BIF-153', 'Hoya', 'BIFOCAL', 'Policarbonato', 'Hard coat', 153, 22000000, 42000000, 15, 4),
            ('f4444444-4444-4444-8444-444444444444', 'ZEISS-OCC-160', 'Zeiss', 'OCCUPATIONAL', 'Organic', 'DuraVision Blue', 160, 38000000, 72000000, 10, 3),
            ('f5555555-5555-4555-8555-555555555555', 'HOYA-PROG-167', 'Hoya', 'PROGRESSIVE', 'High-index', 'Antireflejo premium', 167, 52000000, 98000000, 8, 2),
            ('f6666666-6666-4666-8666-666666666666', 'CRIZ-MONO-149', 'Crizal', 'MONOFOCAL', 'Organic', 'Crizal Sapphire', 149, 25000000, 48000000, 25, 5),
            ('f7777777-7777-4777-8777-777777777777', 'ESS-BIF-150', 'Essilor', 'BIFOCAL', 'Mineral', 'Antiraya', 150, 16000000, 30000000, 12, 3),
            ('f8888888-8888-4888-8888-888888888888', 'ZEISS-MONO-174', 'Zeiss', 'MONOFOCAL', 'High-index', 'UVProtect', 174, 40000000, 75000000, 6, 2)
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            lens_type = EXCLUDED.lens_type,
            material = EXCLUDED.material,
            coating = EXCLUDED.coating,
            stock = EXCLUDED.stock,
            sale_price_cents = EXCLUDED.sale_price_cents;
    END IF;
END
$seed$;
