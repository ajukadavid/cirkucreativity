# Supabase Database & Monnify Payment Setup Instructions

## Step 1: Set up Monnify Credentials

1. Go to your Monnify Dashboard: https://app.monnify.com
2. Navigate to **Settings** → **API Keys & Webhooks**
3. Copy your **API Key** and **Contract Code**
4. Create a `.env` file in your project root with:
   ```
   MONNIFY_API_KEY=your_api_key_here
   MONNIFY_CONTRACT_CODE=your_contract_code_here
   ```
5. **Important**: For production, use your LIVE API key and contract code. For testing, use TEST credentials.

## Step 2: Run the Migration SQL

1. Go to your Supabase Dashboard: https://supabase.com/dashboard
2. Select your project
3. Navigate to **SQL Editor** in the left sidebar
4. Click **New Query**
5. Copy and paste the contents of `supabase_migration.sql`
6. Click **Run** to execute the migration

## Step 2: Verify the Table Structure

After running the migration, verify the table structure by running:

```sql
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'users' 
ORDER BY ordinal_position;
```

You should see these columns:
- `id` (auto-generated primary key)
- `name` (TEXT, NOT NULL)
- `email` (TEXT, NOT NULL)
- `phone` (TEXT, nullable)
- `event_type` (TEXT, nullable)
- `session` (TEXT, nullable)
- `design_image` (TEXT, nullable) - stores the image URL
- `consent` (BOOLEAN, default false)
- `amount` (INTEGER, default 100000)
- `status` (TEXT, default 'pending_payment')
- `payment_reference` (TEXT, nullable) - Monnify payment reference
- `transaction_reference` (TEXT, nullable) - Monnify transaction reference
- `payment_method` (TEXT, nullable) - Payment method used (CARD, ACCOUNT_TRANSFER, etc.)
- `paid_at` (TIMESTAMP, nullable) - When payment was completed
- `created_at` (TIMESTAMP)
- `updated_at` (TIMESTAMP)

## Step 3: Set up Storage Bucket (if not already done)

The form uploads design images to Supabase Storage. Make sure you have a bucket named `designs`:

1. Go to **Storage** in your Supabase Dashboard
2. If the `designs` bucket doesn't exist, create it:
   - Click **New bucket**
   - Name: `designs`
   - Make it **Public** (or adjust RLS policies as needed)
3. Set up Row Level Security (RLS) policies if needed

## Step 4: Set up Row Level Security (RLS)

If you want to enable RLS on the users table:

```sql
-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Allow inserts (for form submissions)
CREATE POLICY "Allow public inserts" ON users
FOR INSERT
TO public
WITH CHECK (true);

-- Allow reads (adjust as needed for your use case)
CREATE POLICY "Allow public reads" ON users
FOR SELECT
TO public
USING (true);
```

## Step 5: Configure Monnify Webhook (Optional but Recommended)

For production, set up a webhook to receive payment notifications:

1. Go to Monnify Dashboard → **Settings** → **Webhooks**
2. Add your webhook URL (e.g., `https://yourdomain.com/api/monnify-webhook`)
3. Select events: **Transaction Status Changed**
4. This ensures you receive payment confirmations even if the user closes the browser

## Step 6: Test the Payment Flow

1. **Test Mode**: Use Monnify test credentials to test the payment flow
2. **Test Cards**: Check Monnify documentation for test card numbers
3. After completing the above steps, test your form submission and payment flow

### Payment Flow:
1. User fills out the booking form
2. User clicks "Complete Payment"
3. Monnify payment modal opens
4. User selects payment method (Card, Bank Transfer, USSD, Phone Number)
5. User completes payment
6. On success, user is redirected to `/final` page
7. Database is updated with payment status and details

## Troubleshooting

### Error: "column does not exist"
- Make sure you ran the migration SQL completely
- Check that all columns were added successfully

### Error: "relation does not exist"
- The `users` table might not exist. Create it first:
```sql
CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL
);
```
Then run the migration again.

### Error: "permission denied"
- Check your RLS policies
- Verify your Supabase anon key is correct in `nuxt.config.ts`

