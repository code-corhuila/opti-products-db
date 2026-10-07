-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Extra frames beyond V009. Idempotent. Prices in cents.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO products.frame (id, sku, brand, model, color, material, gender, cost_cents, sale_price_cents, stock, min_stock, location, supplier)
        VALUES
            ('e1111111-1111-4111-8111-111111111111', 'PLN-PLD4139', 'Polaroid', 'PLD4139', 'Negro mate', 'Acetato', 'Unisex', 12000000, 22000000, 12, 3, 'Vitrina 1', 'Safilo'),
            ('e2222222-2222-4222-8222-222222222222', 'GUESS-GU1983', 'Guess', 'GU1983', 'Dorado', 'Metal', 'Women', 9800000, 18500000, 7, 2, 'Vitrina 2', 'Marcolin'),
            ('e3333333-3333-4333-8333-333333333333', 'AR-AR7170', 'Emporio Armani', 'AR7170', 'Havana', 'Acetato', 'Men', 28000000, 48000000, 4, 2, 'Vitrina premium', 'Luxottica Colombia'),
            ('e4444444-4444-4444-8444-444444444444', 'NK-NK5010', 'Nike', 'NK5010', 'Negro/rojo', 'Inyectado', 'Unisex', 15000000, 27500000, 9, 3, 'Deportivos', 'Marchon'),
            ('e5555555-5555-4555-8555-555555555555', 'CAR-CAR254', 'Carrera', 'CAR254', 'Azul', 'Metal', 'Men', 17500000, 31000000, 6, 2, 'Vitrina 1', 'Safilo'),
            ('e6666666-6666-4666-8666-666666666666', 'MJ-MJ1025', 'Marc Jacobs', 'MJ1025', 'Rosa', 'Acetato', 'Women', 21000000, 39000000, 5, 2, 'Vitrina 2', 'Safilo'),
            ('e7777777-7777-4777-8777-777777777777', 'PERS-PO3256', 'Persol', 'PO3256', 'Carey', 'Acetato', 'Unisex', 32000000, 55000000, 3, 1, 'Vitrina premium', 'Luxottica Colombia'),
            ('e8888888-8888-4888-8888-888888888888', 'FOS-FOS7090', 'Fossil', 'FOS7090', 'Gris', 'Metal', 'Unisex', 11000000, 19900000, 15, 4, 'Almacen', 'Safilo')
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            model = EXCLUDED.model,
            color = EXCLUDED.color,
            material = EXCLUDED.material,
            gender = EXCLUDED.gender,
            stock = EXCLUDED.stock,
            sale_price_cents = EXCLUDED.sale_price_cents,
            location = EXCLUDED.location,
            supplier = EXCLUDED.supplier;
    END IF;
END
$seed$;
