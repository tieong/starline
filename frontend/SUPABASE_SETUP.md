# Supabase Setup Guide for Starline

This guide will help you set up Supabase authentication and database for the Starline influencer platform.

## Prerequisites

- A Supabase account (sign up at https://supabase.com)
- Access to your Supabase project dashboard

## Step 1: Create a Supabase Project

1. Go to https://supabase.com/dashboard
2. Click "New Project"
3. Choose your organization
4. Enter project details:
   - **Name**: starline (or your preferred name)
   - **Database Password**: Choose a secure password
   - **Region**: Select the closest region to your users
5. Click "Create new project"

## Step 2: Get Your API Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the following values:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon/public key** (this is your public API key)

## Step 3: Configure Environment Variables

1. Open `/frontend/.env` in your project
2. Replace the placeholder values with your actual credentials:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key_here
```

**Important**: Never commit your actual `.env` file to version control. The `.env.example` file should contain placeholders only.

## Step 4: Set Up Database Schema

1. In your Supabase dashboard, go to **SQL Editor**
2. Click "New query"
3. Copy the entire contents of `/frontend/supabase-schema.sql`
4. Paste it into the SQL editor
5. Click "Run" to execute the schema

This will create:
- User profiles table
- Contributions table
- Timeline events, brand signals, network insights, platform corrections, and general context tables
- Row Level Security (RLS) policies
- Triggers for automatic reputation updates
- Indexes for performance

## Step 5: Configure Authentication Settings

### Email Authentication

1. Go to **Authentication** → **Providers**
2. Ensure **Email** is enabled
3. Configure email templates (optional):
   - Go to **Authentication** → **Email Templates**
   - Customize the confirmation, invite, and password reset emails

### Email Confirmation Settings

By default, Supabase requires email confirmation. For development, you may want to disable this:

1. Go to **Authentication** → **Settings**
2. Under "Email Auth", toggle **Enable email confirmations** OFF (for development only)
3. For production, keep email confirmation enabled

## Step 6: Test the Authentication

1. Start your development server:
   ```bash
   npm run dev
   ```

2. Navigate to an influencer detail page
3. Click "Contribute Insight"
4. You should see the authentication modal
5. Try creating a new account:
   - Enter a username
   - Enter your email
   - Choose a password (minimum 6 characters)
   - Click "Create Account"

6. Check your Supabase dashboard:
   - Go to **Authentication** → **Users**
   - You should see your new user
   - Go to **Database** → **user_profiles**
   - Your profile should be created automatically

## Step 7: Verify Database Tables

In the Supabase dashboard, go to **Database** → **Tables**. You should see:

- `user_profiles` - User account and reputation data
- `contributions` - User-submitted insights (pending/approved/rejected)
- `timeline_events` - Approved timeline events
- `brand_signals` - Approved brand collaborations
- `network_insights` - Approved network connections
- `platform_corrections` - Platform data corrections
- `general_context` - General contextual information

## Database Schema Overview

### User Profiles Table

Stores user account information and reputation metrics:
- `id` - UUID (matches auth.users.id)
- `username` - Unique username
- `email` - User email
- `avatar` - Profile picture URL (optional)
- `reputation_score` - 0-100 score based on contribution quality
- `total_submissions` - Total number of contributions
- `approved_submissions` - Number of approved contributions
- `flagged_submissions` - Number of flagged/rejected contributions
- `badges` - JSONB array of earned badges
- `contribution_history` - JSONB array of monthly contribution counts

### Contributions Table

All user-submitted insights are stored here:
- Supports 5 types: timeline-event, brand-signal, network-insight, platform-correction, general-context
- Each contribution has a status: pending, approved, rejected, or flagged
- Contributions are linked to specific influencers and users
- Includes confidence level (0-100) set by the submitter

### Automatic Reputation Updates

The database includes triggers that automatically update user reputation:
- **+5 points** when a contribution is approved
- **-10 points** when a contribution is flagged
- Scores are capped between 0 and 100
- `total_submissions` increments when a new contribution is created

## Row Level Security (RLS)

All tables have RLS enabled with these policies:

- **User Profiles**: Anyone can view, users can update their own profile
- **Contributions**: Anyone can view, users can create and edit their own pending contributions
- **Approved Content**: All approved content (timeline events, brand signals, etc.) is publicly readable

## Troubleshooting

### "Missing Supabase environment variables"

**Issue**: You see this error when starting the app.

**Solution**: Make sure you've set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` in your `.env` file.

### Authentication not working

**Possible causes**:
1. Check that your Supabase URL and anon key are correct
2. Verify that Email authentication is enabled in Supabase dashboard
3. Check browser console for specific error messages
4. Ensure the `user_profiles` table exists and has proper RLS policies

### User profile not created after signup

**Issue**: User can sign up but profile doesn't appear in `user_profiles` table.

**Solution**:
1. Check the browser console for errors
2. Verify the `user_profiles` table exists
3. Check that the RLS policy allows inserts
4. Ensure the database schema was executed correctly

### Session not persisting

**Issue**: User is logged out when refreshing the page.

**Solution**:
- Supabase automatically persists sessions in localStorage
- Check browser console for auth errors
- Verify that the AuthProvider is wrapping your entire app in `App.tsx`

## Production Deployment

When deploying to production:

1. **Update environment variables** on your hosting platform (Vercel, Netlify, etc.):
   ```
   VITE_SUPABASE_URL=your_production_supabase_url
   VITE_SUPABASE_ANON_KEY=your_production_anon_key
   ```

2. **Enable email confirmations**:
   - Go to Authentication → Settings
   - Enable "Enable email confirmations"
   - Configure your email templates

3. **Set up custom domain** (optional):
   - In Supabase dashboard, go to Settings → General
   - Add your custom domain

4. **Monitor usage**:
   - Check your Supabase dashboard regularly
   - Set up billing alerts if needed

## Next Steps

After setting up Supabase:

1. **Customize badges**: Edit the badge definitions in your application logic
2. **Add moderation**: Create an admin interface to review pending contributions
3. **Implement notifications**: Use Supabase Realtime to notify users when contributions are reviewed
4. **Add analytics**: Track contribution metrics and user engagement

## Support

- Supabase Documentation: https://supabase.com/docs
- Supabase Discord: https://discord.supabase.com
- Starline Issues: [Your GitHub repository issues page]
