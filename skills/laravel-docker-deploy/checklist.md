# Post-scaffold checklist

Fill placeholders with the interview answers. Never put secret *values* in the repo or chat.

## GitHub repository

- [ ] Repo is on GitHub; Actions enabled
- [ ] Package write works via `GITHUB_TOKEN` (default for GHCR push from Actions)
- [ ] After first successful deploy, confirm package `__GHCR_IMAGE__` exists under GitHub Packages
- [ ] If the package is private: server can `docker login ghcr.io` (or use a pull credential you manage outside this skill)

## GitHub Actions secrets

Add under **Settings → Secrets and variables → Actions**:

| Secret | Purpose |
|--------|---------|
| `SERVER_HOST` | VPS hostname/IP reachable over Tailscale (or public SSH if no Tailscale) |
| `SERVER_USER` | SSH user |
| `SSH_PRIVATE_KEY` | Private key for that user (full PEM) |
| `TS_OAUTH_CLIENT_ID` | Tailscale OAuth client ID (omit workflow steps if not using Tailscale) |
| `TS_OAUTH_SECRET` | Tailscale OAuth secret |

Also add any extra secrets named during the interview.

## Tailscale (if enabled)

- [ ] OAuth client can use tag `tag:deploy`
- [ ] Server is on the tailnet; `SERVER_HOST` is the Tailscale IP or MagicDNS name
- [ ] ACL allows the GitHub Action identity to SSH to the server

## Server directory `__SERVER_DIR__`

- [ ] Directory exists; git remote points at this repo; branch `__DEPLOY_BRANCH__` checked out
- [ ] Docker + Docker Compose plugin installed
- [ ] Files present (from git pull): `compose.prod.yaml`, and after first deploy the image pull works
- [ ] `.env` and `.env.production` created on the server (not in git)
- [ ] If using Docker secrets:
  - [ ] `secrets/db_password.txt` (single line, no extra newline issues)
  - [ ] `secrets/db_root_password.txt`
  - [ ] `secrets/` is gitignored and not world-readable
- [ ] Host reverse proxy (Caddy/Nginx) forwards the public site to `127.0.0.1:__PROD_HOST_PORT__`
- [ ] Optional: `docker login ghcr.io` as a user that can pull `__GHCR_IMAGE__`

## First bring-up

- [ ] Push to `__DEPLOY_BRANCH__` (or run workflow) and confirm **test** + **deploy** jobs pass
- [ ] On server: container healthy; `php artisan migrate --force` ran
- [ ] Hit the app through the reverse proxy
- [ ] Note a good SHA from GHCR tags for a dry-run rollback

## Rollback smoke test

- [ ] Actions → **Rollback** → workflow_dispatch with a previous full SHA
- [ ] Confirm `.app_image_tag` updates and app serves the older image

## Local / dev (optional)

- [ ] Copy `.env.example` → `.env` with `DB_*` matching compose.dev
- [ ] `npm run docker:dev:up` (or `docker compose -f compose.dev.yaml up -d --build`)
- [ ] App on `http://localhost:__DEV_APP_PORT__`
