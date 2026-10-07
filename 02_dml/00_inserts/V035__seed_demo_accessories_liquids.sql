-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Idempotent. Prices in cents. Fixed ids so sales demo orders can reference them.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO products.accessory (id, sku, brand, category, cost_cents, sale_price_cents, stock, min_stock)
        VALUES
            ('a1111111-1111-4111-8111-111111111111', 'CASE-HARD-01', 'OptiView', 'Estuche', 3500000, 8900000, 50, 10),
            ('a2222222-2222-4222-8222-222222222222', 'CLOTH-MIC-01', 'OptiView', 'Panuelo', 800000, 2500000, 80, 15),
            ('a3333333-3333-4333-8333-333333333333', 'STRAP-SPORT', 'Chums', 'Cordon', 4500000, 12000000, 30, 5),
            ('a4444444-4444-4444-8444-444444444444', 'NOSE-PAD-KIT', NULL, 'Repuesto', 1500000, 4500000, 40, 8),
            ('a5555555-5555-4555-8555-555555555555', 'CASE-SOFT-02', 'Ray-Ban', 'Estuche', 6000000, 15000000, 20, 4),
            ('a6666666-6666-4666-8666-666666666666', 'CLEAN-SPRAY', 'OptiView', 'Limpieza', 2000000, 5500000, 35, 8)
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            category = EXCLUDED.category,
            stock = EXCLUDED.stock,
            sale_price_cents = EXCLUDED.sale_price_cents;

        INSERT INTO products.liquid (id, sku, brand, volume_ml, cost_cents, sale_price_cents, stock, min_stock)
        VALUES
            ('b1111111-1111-4111-8111-111111111111', 'SOL-REN-360', 'Renu', 360, 18000000, 32000000, 25, 5),
            ('b2222222-2222-4222-8222-222222222222', 'SOL-OPT-120', 'Opti-Free', 120, 9000000, 18000000, 40, 8),
            ('b3333333-3333-4333-8333-333333333333', 'SOL-BIO-300', 'Biotrue', 300, 16000000, 29000000, 18, 4),
            ('b4444444-4444-4444-8444-444444444444', 'CLN-SPRAY-50', 'OptiView', 50, 4000000, 9500000, 60, 10),
            ('b5555555-5555-4555-8555-555555555555', 'SOL-ACU-355', 'Acuvue', 355, 20000000, 36000000, 12, 3)
        ON CONFLICT (id) DO UPDATE SET
            brand = EXCLUDED.brand,
            volume_ml = EXCLUDED.volume_ml,
            stock = EXCLUDED.stock,
            sale_price_cents = EXCLUDED.sale_price_cents;
    END IF;
END
$seed$;
