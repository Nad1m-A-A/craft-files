# Docker Learning Plan — Laravel + Inertia/React

A practical path to learn Docker for **both local development and production** — built from scratch first, then Sail, so you understand what the shortcuts hide.

## How to use this plan

- Learn one concept at a time. Confirm it clicks, then move on.
- Prefer the **"why" before the "how"**.
- Prefer the idiomatic Laravel/Docker approach — reliable over clever.
- Check off items as you go.

## Prerequisites (mental model)

Before writing a Dockerfile, lock these three ideas:

- **Dockerfile** = the blueprint/recipe for building an image.
- **Image** = a read-only, layered template (a "screenshot" of the environment).
- **Container** = a running instance of an image.

## Typical stack this plan targets

- Laravel 13, PHP 8.4+, Inertia + React, Vite, Tailwind.
- Auth (e.g. Fortify), optional permissions packages.
- SQLite for simple local work; MySQL as the usual production database.
- Queue / sessions / cache often on `database` early on; mail via `log` in local.

Sail may already be installed as a dev dependency. You can still start with a clean slate: **Dockerfile and Compose from scratch first**, Sail second.

## How a Dockerfile blueprint is decided (5 factors)

1. **Runtime** the code needs (PHP 8.4+ and required extensions) → picks the `FROM` base image.
2. **Build-only tools** (Composer, Node/npm for `vite build`) → leads to multi-stage builds.
3. **How the app is served** (php-fpm + Nginx, or all-in-one) → decides `CMD` / entrypoint.
4. **Dev vs prod** (mounted source + dev deps + HMR vs frozen image + `--no-dev` + built assets).
5. **Layer ordering for cache** (copy dependency manifests first, install, *then* copy code).

## Curriculum

- [ ] 1. Core concepts: images, layers, containers, registries
- [ ] 2. First Dockerfile from scratch (the 5 factors), built step by step
- [ ] 3. Volumes & the `node_modules` / `vendor` gotcha
- [ ] 4. Docker Compose: multi-service local stack (app + MySQL)
- [ ] 5. Laravel Sail (the fast local-dev path) — and why it's **not** for production
- [ ] 6. Multi-stage production Dockerfile (lean image, built assets, `--no-dev`)
- [ ] 7. Networking, env vars, secrets (dev vs prod)
- [ ] 8. Deployment with GitHub Actions CI/CD

## Key clarifications worth keeping nearby

- Dockerfile "language" ≈ a small set of declarative instructions (`FROM`, `COPY`, `RUN`, `CMD`…) wrapping ordinary Linux shell commands.
- **Compose** = run many containers together; **Dockerfile** = build one image.
- **Sail** = a pre-made Compose setup for Laravel **local development**; not a production tool.
- On Windows, prefer WSL or PowerShell-friendly commands when following Linux-oriented Docker docs.

## Suggested teaching style (if you pair with an AI or mentor)

Ask them to:

1. Explain the why before the how.
2. Go one concept at a time — no dumping full configs in one go.
3. Call out common traps (volume mounts wiping `vendor`/`node_modules`, Sail ≠ prod, secrets vs `.env` in images).
4. Prefer the standard Laravel + Docker approach over custom one-offs.
