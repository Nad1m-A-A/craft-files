---
name: laravel-docker-deploy
description: >-
  Scaffold Laravel Docker prod/dev setup with multi-stage Dockerfile, Compose,
  GHCR CI deploy + rollback, Tailscale SSH, and Docker secrets. Use when the
  user asks for Docker setup, production deploy, GHCR workflows, compose
  files, Dockerfile.prod/dev, or server rollback.
---

# Laravel Docker Deploy

Opinionated scaffold matching a proven Laravel + Vite + Apache + MySQL + GHCR + Tailscale pattern.

**Why this shape:** build once in CI, ship an immutable image tagged by git SHA, pull on the server over Tailscale, keep DB passwords in Docker secrets (not in compose env), and keep a one-click rollback to a previous SHA.

## Workflow

Copy and track:

```
Scaffold progress:
- [ ] 1. Interview complete
- [ ] 2. Files written from templates/
- [ ] 3. package.json docker scripts added
- [ ] 4. Checklist delivered to user
```

### Step 1 — Interview (required before writing files)

Ask only what you still need. Prefer a short numbered list. Defaults in parentheses.

1. **Project slug** — image/repo name (e.g. `dashboards`)
2. **GHCR owner** — GitHub user/org for `ghcr.io/{owner}/{slug}`
3. **Server app directory** — absolute path on VPS (e.g. `/var/www/example.com`)
4. **Container workdir** — path inside image (default: `/var/www/{slug}`)
5. **PHP / Node / MySQL versions** (defaults: `8.4` / `22` / `8.4`)
6. **Ports** — prod host bind (default `8010`), dev app `8000`, Vite `5173`
7. **MySQL in Compose?** (default: yes)
8. **Docker secrets for DB?** (default: yes — `db_password`, `db_root_password`)
9. **Tailscale for deploy SSH?** (default: yes)
10. **Deploy branch** (default: `main`)
11. **Wayfinder generate in prod build?** (default: yes if `@laravel/vite-plugin-wayfinder` or wayfinder is in the project)
12. **Extra GitHub secrets beyond the standard set?** (list names only — never ask for secret *values*)

Do **not** ask the user to paste private keys or passwords into chat. Checklist tells them where to put those.

### Step 2 — Generate files

Read templates under this skill’s `templates/` directory. Substitute placeholders (see below). Write into the **target project root** (or paths the user specified).

| Output path | Template |
|-------------|----------|
| `Dockerfile.prod` | `templates/Dockerfile.prod` |
| `Dockerfile.dev` | `templates/Dockerfile.dev` |
| `compose.prod.yaml` | `templates/compose.prod.yaml` |
| `compose.dev.yaml` | `templates/compose.dev.yaml` |
| `.dockerignore` | `templates/dockerignore` |
| `docker/entrypoint.prod.sh` | `templates/entrypoint.prod.sh` |
| `.github/workflows/deploy.yml` | `templates/deploy.yml` |
| `.github/workflows/rollback.yml` | `templates/rollback.yml` |

**Conditionals:**

- If MySQL = no → remove `mysql` service, volumes, and `depends_on` from both compose files; drop secret wiring for DB if unused.
- If Docker secrets = no → use env vars for MySQL passwords in prod (dev-style); simplify `entrypoint.prod.sh` to `exec docker-php-entrypoint "$@"`.
- If Tailscale = no → remove Tailscale steps from both workflows; document that `SERVER_HOST` must be reachable from GitHub runners.
- If Wayfinder = no → remove the `php artisan wayfinder:generate` line from `Dockerfile.prod`.

Merge **docker npm scripts** from `templates/package-scripts.json` into the project’s `package.json` `scripts` (do not wipe unrelated scripts).

Never commit real secrets. Ensure `.gitignore` includes:

```
.env
.env.production
secrets/
.app_image_tag
```

### Step 3 — Deliver checklist

After writing files, show the user the checklist in [checklist.md](checklist.md), filled with their answers (image name, server path, secret names). Do not invent secret values.

## Placeholders

Use `__NAME__` only (never `{{ }}`) so GitHub Actions `${{ secrets.* }}` / `${{ github.sha }}` stay untouched.

| Placeholder | Example |
|-------------|---------|
| `__PROJECT_SLUG__` | `dashboards` |
| `__GHCR_OWNER__` | `nad1m-a-a` |
| `__GHCR_IMAGE__` | `ghcr.io/nad1m-a-a/dashboards` |
| `__COMPOSE_PROD_NAME__` | `prod-dashboards` |
| `__COMPOSE_DEV_NAME__` | `dev-dashboards` |
| `__SERVER_DIR__` | `/var/www/dashboards.nadimweb.com` |
| `__CONTAINER_WORKDIR__` | `/var/www/dashboards` |
| `__PHP_VERSION__` | `8.4` |
| `__NODE_VERSION__` | `22` |
| `__MYSQL_VERSION__` | `8.4` |
| `__PROD_HOST_PORT__` | `8010` |
| `__DEV_APP_PORT__` | `8000` |
| `__DEV_VITE_PORT__` | `5173` |
| `__DEPLOY_BRANCH__` | `main` |

`__GHCR_IMAGE__` = `ghcr.io/__GHCR_OWNER__/__PROJECT_SLUG__` (no tag).

NodeSource URLs look like `setup___NODE_VERSION__.x` on purpose: after substituting `__NODE_VERSION__` → `22` you get `setup_22.x`. Do not “fix” the triple underscore.

## Rules

- Prefer these templates over inventing a new Docker layout.
- Keep prod image multi-stage: build artifacts in `build`, lean Apache runtime.
- Tag images `latest` + full `github.sha`; rollback sets `APP_IMAGE_TAG` to that SHA.
- Prod app binds `127.0.0.1:__PROD_HOST_PORT__:80` (reverse proxy on host).
- Comments in generated files should stay short and practical (match template tone).
- If the project already has Docker/CI files, diff against templates and ask before overwriting.
