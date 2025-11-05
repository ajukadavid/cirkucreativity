-- Migration script to update the users table for the new CIRKU booking form
-- Run this in your Supabase SQL Editor

-- First, let's check if the table exists and what columns it has
-- You can check this by running: SELECT * FROM information_schema.columns WHERE table_name = 'users';

-- Add new columns if they don't exist
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS phone TEXT,
ADD COLUMN IF NOT EXISTS session TEXT,
ADD COLUMN IF NOT EXISTS design_image TEXT,
ADD COLUMN IF NOT EXISTS consent BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS amount INTEGER DEFAULT 100000,
ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending_payment',
ADD COLUMN IF NOT EXISTS payment_reference TEXT,
ADD COLUMN IF NOT EXISTS transaction_reference TEXT,
ADD COLUMN IF NOT EXISTS payment_method TEXT,
ADD COLUMN IF NOT EXISTS paid_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- Make old columns optional (if they exist and you want to keep them for backward compatibility)
-- If you want to remove old columns instead, uncomment the lines below:
-- ALTER TABLE users DROP COLUMN IF EXISTS gender;
-- ALTER TABLE users DROP COLUMN IF EXISTS insta;
-- ALTER TABLE users DROP COLUMN IF EXISTS vid;

-- Ensure name and email are NOT NULL (they should be required)
ALTER TABLE users 
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN email SET NOT NULL;

-- Create an index on email for faster lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Create an index on status for filtering bookings
CREATE INDEX IF NOT EXISTS idx_users_status ON users(status);

-- Optional: Add a trigger to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at 
    BEFORE UPDATE ON users 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Verify the table structure
-- You can run this to see the final structure:
-- SELECT column_name, data_type, is_nullable 
-- FROM information_schema.columns 
-- WHERE table_name = 'users' 
-- ORDER BY ordinal_position;

