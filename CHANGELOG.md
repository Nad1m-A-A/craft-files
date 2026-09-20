# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Changed

- Scaffold now writes Dockerfiles, Compose, and the entrypoint under `docker/`. `.dockerignore` stays at the project root; GitHub Actions stay in `.github/workflows/`.

## [2026-09-20]

### Changed

- Renamed skill `laravel-docker-deploy` to `laravel-inertia-docker-deploy`.

### Added

- Optional worker (`queue:work`) and scheduler (`schedule:work`) containers in the Laravel Inertia Docker skill, including worker replicas.
- Deploy path allowlists, an image-vs-compose `changes` job, and GitHub Actions Buildx cache so compose-only pushes skip an image rebuild.

## [2026-07-22]

### Added

- Learning plans for Docker and testing.
- Skills: `laravel-docker-deploy`, `incremental-teaching`.
