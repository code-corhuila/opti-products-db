-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Idempotent: running it again changes nothing but descriptive columns. Prices in cents.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO products.frame (id, sku, brand, model, color, material, gender, cost_cents, sale_price_cents, stock, min_stock, location, supplier)
        VALUES
            ('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa', 'RB5228-2000', 'Ray-Ban', 'RB5228', 'Matte black', 'Acetate', 'Unisex', 31000000, 52000000, 8, 2, 'Main display', 'Luxottica Colombia'),
            ('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb', 'OAK-HOLB-001', 'Oakley', 'Holbrook OX8156', 'Smoke grey', 'Grilamid', 'Men', 26500000, 44500000, 0, 2, 'Warehouse', 'Marchon'),
            ('cccccccc-cccc-4ccc-8ccc-cccccccccccc', 'VOG-VO5239', 'Vogue', 'VO5239', 'Havana', 'Acetate', 'Women', 14800000, 26800000, 5, 3, 'Display 2', 'Luxottica Colombia'),
            ('dddddddd-dddd-4ddd-8ddd-dddddddddddd', 'TOM-TH1846', 'Tommy Hilfiger', 'TH1846', 'Blue', 'Metal', 'Unisex', 19000000, 33000000, 3, 2, 'Main display', 'Safilo')
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            model = EXCLUDED.model,
            color = EXCLUDED.color,
            material = EXCLUDED.material,
            gender = EXCLUDED.gender,
            location = EXCLUDED.location,
            supplier = EXCLUDED.supplier;
    END IF;
END
$seed$;
