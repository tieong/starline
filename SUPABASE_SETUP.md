# Supabase Database Setup Guide

This guide will help you set up Supabase as the database backend for Starline.

## Prerequisites

- A Supabase account (sign up at [supabase.com](https://supabase.com))
- Access to your Supabase project dashboard

## Step 1: Create a Supabase Project

1. Go to [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Click "New Project"
3. Fill in your project details:
   - **Name**: `starline` (or your preferred name)
   - **Database Password**: Choose a strong password (save this!)
   - **Region**: Choose the region closest to your users
   - **Pricing Plan**: Free tier works great for development
4. Click "Create new project" and wait for it to provision (takes ~2 minutes)

## Step 2: Get Your Database Connection String

1. In your Supabase project dashboard, go to **Settings** (gear icon) → **Database**
2. Scroll down to **Connection string**
3. Select **Connection pooling** tab (recommended for better performance)
4. Copy the **Connection string** that looks like:
   ```
   postgresql://postgres.[PROJECT-REF]:[YOUR-PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres
   ```
5. Replace `[YOUR-PASSWORD]` with your actual database password from Step 1

## Step 3: Configure Environment Variables

### For Local Development (backend only):

1. Navigate to the `backend` directory
2. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
3. Edit `.env` and update the `DATABASE_URL`:
   ```env
   DATABASE_URL=postgresql://postgres.[YOUR-PROJECT-REF]:[YOUR-PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres?pgbouncer=true
   ```

### For Docker Deployment:

1. In the project root, copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
2. Edit `.env` and set:
   ```env
   SUPABASE_DATABASE_URL=postgresql://postgres.[YOUR-PROJECT-REF]:[YOUR-PASSWORD]@aws-0-[REGION].pooler.supabase.com:6543/postgres?pgbouncer=true
   BLACKBOX_API_KEY=your_blackbox_api_key_here
   ```

## Step 4: Run Database Migrations

The application will automatically create the necessary tables when it starts. However, you can manually run migrations if needed:

```bash
# From the backend directory
cd backend
source .venv/bin/activate
alembic upgrade head
```

## Step 5: Verify Connection

Start your backend server:

```bash
# Local development
cd backend
source .venv/bin/activate
uvicorn src.main:app --reload

# Or with Docker
docker-compose up backend
```

You should see logs indicating successful database connection. If you see connection errors, double-check:
- Your connection string is correct
- The password matches your Supabase project
- Your IP is allowed (Supabase allows all IPs by default, but check Settings → Database → Connection Pooling → IP Restrictions if needed)

## Step 6: Access the Supabase Dashboard

You can view and manage your database directly in Supabase:

1. Go to **Table Editor** to see your tables and data
2. Go to **SQL Editor** to run custom queries
3. Go to **Database** → **Backups** to schedule automatic backups

## Important Notes

### Connection Pooling vs Direct Connection

Supabase provides two connection methods:

- **Connection Pooling (Recommended)**: Uses port 6543 with pgbouncer
  - Better for applications with many connections
  - Required for serverless deployments
  - Use this for production

- **Direct Connection**: Uses port 5432
  - Direct access to PostgreSQL
  - Better for migrations and admin tasks
  - May hit connection limits faster

We use **Connection Pooling** by default in the configuration.

### Security Best Practices

1. **Never commit your `.env` file** - It's already in `.gitignore`
2. **Use strong passwords** for your database
3. **Enable Row Level Security (RLS)** in production:
   - Go to **Authentication** → **Policies**
   - Add RLS policies for your tables
4. **Rotate credentials** periodically
5. **Use Supabase's built-in Auth** if you add user authentication

### Migration from Local PostgreSQL

If you were previously using the local PostgreSQL container:

1. Export your local data:
   ```bash
   pg_dump -h localhost -p 5433 -U starline starline > backup.sql
   ```

2. Import to Supabase using the SQL Editor:
   - Go to Supabase Dashboard → SQL Editor
   - Paste your SQL dump
   - Run the query

Or use the Supabase CLI:
```bash
supabase db push
```

## Troubleshooting

### Connection Timeout
- Check your firewall settings
- Verify the connection string is correct
- Ensure your Supabase project is not paused (free tier pauses after inactivity)

### Too Many Connections
- Switch to connection pooling (port 6543)
- Close idle connections in your application
- Upgrade your Supabase plan if needed

### Migration Errors
- Ensure your Supabase project is active
- Check that you're using the correct connection string for migrations (direct connection on port 5432)
- Review the Alembic migration logs for specific errors

## Useful Supabase Features

1. **Real-time Subscriptions**: Enable real-time data updates
2. **Storage**: Built-in object storage for files
3. **Edge Functions**: Serverless functions
4. **Auth**: Built-in authentication system
5. **Logs**: Real-time logs and monitoring

## Need Help?

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Discord Community](https://discord.supabase.com)
- [Starline Issues](https://github.com/your-repo/starline/issues)
