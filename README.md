# Inventory

A web app for managing inventories: offices, libraries, warehouses — anything you need to keep track of.
Each inventory gets its own custom fields and its own item ID format; other users can be given write access to add items.

**Live:** https://inventory.185-174-255-157.sslip.io

## Features

- Sign in with Google, GitHub, or email and password
- Inventories with Markdown description, category, tags, image and public/private access
- Custom fields (string, text, number, link, boolean — up to 3 of each), reordered by drag and drop
- Custom item IDs built from fixed text, random numbers, GUID, date/time and a sequence, with a live preview
- Items table, item page, likes
- Real-time discussion on every inventory
- Statistics per inventory field
- Auto-save every 8 seconds and optimistic locking for inventories and items
- Full-text search, tag cloud, personal page with sortable tables
- Admin panel: block, unblock, promote, demote, delete users
- English and Uzbek UI, light and dark theme, mobile friendly

## Stack

Ruby 4, Rails 8.1, PostgreSQL, Hotwire (Turbo + Stimulus), importmap, Bootstrap 5,
Devise + OmniAuth, Pundit, Ransack, pg_search, Kaminari, Redcarpet,
Active Storage with S3-compatible storage (Supabase), Action Cable, Tom Select, SortableJS.

## Run locally

```bash
bundle install
cp .env.example .env
bin/rails db:prepare
bin/rails server
```

Fill `.env` as needed:

| Variable | Purpose |
|---|---|
| `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` | Google sign-in |
| `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` | GitHub sign-in |
| `S3_ENDPOINT`, `S3_REGION`, `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY` | Image storage; without them images go to `storage/` |
| `ADMIN_EMAIL`, `ADMIN_PASSWORD` | `bin/rails db:seed` creates an admin with these |

## Deploy

The app runs on a VPS with Docker Compose (Rails + PostgreSQL) behind Caddy, which provides HTTPS.
To update the server after a push:

```bash
ssh root@185.174.255.157 'cd /opt/inventory && git -C app pull && docker compose up -d --build'
```

Migrations run automatically on start.
