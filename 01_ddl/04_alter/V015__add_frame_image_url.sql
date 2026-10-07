-- frame.image_url: public relative path of the uploaded photo (for example /media/frames/<id>.jpg).
-- Nullable: most frames start without a photo. Never an absolute disk path (HU-16).
ALTER TABLE products.frame ADD COLUMN image_url text;

COMMENT ON COLUMN products.frame.image_url IS
    'Public relative path served by the gateway under /media/frames/, not the on-disk location.';
