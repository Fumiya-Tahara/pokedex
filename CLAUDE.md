# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Principles

@.claude/tdd.md

## Commands

**Start development environment:**
```bash
docker compose up --build
docker compose exec app bin/rails db:create
```

**Run tests:**
```bash
bin/rails db:test:prepare test   # or
bundle exec rspec
```

**Lint and security checks:**
```bash
bin/rubocop -f github            # Ruby style (Omakase)
bin/brakeman --no-pager          # Security scanning
bin/bundler-audit                # Gem vulnerability check
bin/importmap audit              # JS dependency audit
```

**Run a single spec file:**
```bash
bundle exec rspec spec/path/to/spec_file.rb
```

## Architecture

Rails 8.1 application with MySQL. Uses **Solid** services instead of Redis: Solid Cache, Solid Queue, Solid Cable — each backed by a separate database in production.

**Frontend:** Hotwire (Turbo + Stimulus) with Importmap (no Node/bundler). Assets via Propshaft.

**Database:** MySQL 8.0, configured via environment variables. The `DATABASE_URL` (or separate `DB_*` vars) drives all environments. See `.env.example` for required vars.

**CI** (`.github/workflows/ci.yml`) runs four parallel jobs: `scan_ruby` (Brakeman + bundler-audit), `scan_js` (importmap audit), `lint` (RuboCop), and `test` (RSpec with MySQL service).

**Current state:** Early-stage — single route (`root → application#index`), no migrations yet.
