# PHC Resident Doctors Activity Tracker
## Deployment Guide — GitHub + Netlify + Supabase

---

## STEP 1 — Set up Supabase (5 minutes)

1. Go to https://supabase.com and sign in
2. Click **New project**, give it a name (e.g. `phc-roster`), pick a region close to Nigeria (e.g. `eu-west-2` London or `us-east-1`)
3. Wait ~2 minutes for the project to provision
4. In the left sidebar go to **SQL Editor → New Query**
5. Open the file `supabase_schema.sql` from this folder, paste the entire contents into the editor, and click **Run**
   - You should see: `Success. No rows returned`
6. Go to **Settings → API** and copy:
   - **Project URL** → looks like `https://abcdefgh.supabase.co`
   - **anon public** key → long JWT string starting with `eyJ...`

---

## STEP 2 — Push to GitHub (3 minutes)

1. Go to https://github.com and create a **New repository**
   - Name: `phc-roster` (or anything you like)
   - Visibility: **Private** (recommended — your data credentials will be entered by users, not stored in the repo)
   - Do NOT add a README or .gitignore (keep it empty)

2. On your computer, open a terminal in this folder and run:

```bash
git init
git add .
git commit -m "Initial deploy — PHC Roster App"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/phc-roster.git
git push -u origin main
```

Replace `YOUR_USERNAME` with your actual GitHub username.

---

## STEP 3 — Deploy on Netlify (3 minutes)

1. Go to https://netlify.com and sign in
2. Click **Add new site → Import an existing project**
3. Choose **Deploy with GitHub**
4. Authorize Netlify to access your GitHub account
5. Select the `phc-roster` repository
6. Build settings (leave as-is — the `netlify.toml` handles everything):
   - Build command: *(leave empty)*
   - Publish directory: `.`
7. Click **Deploy site**
8. Netlify will give you a URL like `https://amazing-name-123.netlify.app`

### Customize your URL (optional)
- Go to **Site settings → Domain management → Options → Edit site name**
- Change to something like `phc-dept-roster`
- Your site will be at `https://phc-dept-roster.netlify.app`

---

## STEP 4 — First time opening the app

1. Open your Netlify URL in a browser
2. You'll see the **Connect to Supabase** screen
3. Paste in the **Project URL** and **anon key** from Step 1
4. Click **Connect & Load Data**
5. The app loads and syncs — credentials are saved in your browser automatically

Next time you (or anyone) opens the app on the same browser, it connects automatically.

**Sharing with colleagues:**
- Send them the Netlify URL
- They paste the same Supabase URL and anon key once
- Everyone sees the same live data

---

## UPDATING THE APP

When you make changes to `index.html`:

```bash
git add .
git commit -m "Update: describe your change"
git push
```

Netlify auto-deploys within ~30 seconds. No rebuild needed — it's a static file.

---

## FILE SUMMARY

| File | Purpose |
|------|---------|
| `index.html` | The entire app — all pages, charts, forms |
| `supabase_schema.sql` | Run this once in Supabase SQL Editor |
| `netlify.toml` | Netlify configuration and security headers |
| `README.md` | This guide |

---

## TROUBLESHOOTING

**"Connection failed" on setup screen**
- Double-check you copied the full URL (must start with `https://`)
- Make sure you used the `anon` key, not the `service_role` key
- Confirm you ran `supabase_schema.sql` — the tables must exist

**Data not appearing after login**
- Click the **↻ Refresh** button in the bottom bar
- Check Supabase dashboard → Table Editor to confirm tables have data

**Deployed but app shows blank page**
- Check Netlify deploy logs for errors
- Make sure `index.html` is in the root of the repo (not in a subfolder)

**Want to reset all data**
- Go to Supabase → Table Editor → select each table → Delete all rows
- Or run: `TRUNCATE postings, leave_records, activities;` in SQL Editor
