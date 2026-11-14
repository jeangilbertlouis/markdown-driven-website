# Plan: Markdown-driven website (Astro)

## Goals

- **Static site** generated from markdown collections
- Fast, SEO-friendly, zero client JS by default
- Markdown collections: `pages`, `posts` (blog with dates/tags), `nav`
- Features: syntax highlighting, search (Pagefind), dark mode

## Stack

| Layer | Choice |
|-------|--------|
| Framework | **Astro 7** (Rust-compiled, Vite 8 + Rolldown) |
| Language | TypeScript (config + content types) |
| Styling | Tailwind CSS + custom CSS (light/dark tokens) |
| Search | Pagefind (static, zero JS) |
| Syntax highlight | Astro/Shiki built-in |
| Hosting | Any static host (Netlify/GitHub Pages/Cloudflare Pages) |

## Project structure

```
.
├── src/
│   ├── content/
│   │   ├── pages/           # .md files → pages (slug based on filename)
│   │   ├── posts/           # .md files → blog posts
│   │   └── nav/             # .md files → navigation entries
│   ├── layouts/
│   │   └── Layout.astro     # main layout wrapper
│   ├── pages/
│   │   ├── index.astro      # home page
│   │   └── blog/
│   │       ├── index.astro  # blog listing (pagination)
│   │       └── [tag].astro  # tag archive pages
├── public/                  # static assets
├── src/content.config.ts
├── astro.config.mjs
├── package.json
└── PLAN.md                  # this file
```

## Content collections

- `pages` — standalone site pages
- `posts` — blog entries with `pubDate`, optional `updatedDate`, `tags`
- `nav` — navigation entries with `label`, `href`, `order`

## Milestones

### M0 — Project setup
- [x] Scaffold Astro blog template
- [ ] Configure `package.json` scripts (`dev`, `build`, `preview`)
- [ ] Add `astro.config.mjs` integrations (MDX, Tailwind, Sitemap)
- [ ] Update `src/content.config.ts` for the collections above
- [ ] Verify `.gitignore` covers `node_modules`, `dist`, `.astro`

### M1 — Content layer
- [ ] Create `src/content/pages`, `src/content/posts`, `src/content/nav`
- [ ] Add sample `.md` files with frontmatter
- [ ] Implement `Layout.astro`, `index.astro`, verify rendering

### M2 — Blog features
- [ ] `/blog` listing with pagination
- [ ] Tag archive pages (`/blog/tag/:tag`)
- [ ] Post pages with date and tag rendering

### M3 — Search & UI polish
- [ ] Pagefind indexing and search UI (`/search`)
- [ ] Dark/light mode toggle (system preference + persisted choice)
- [ ] Responsive layout & typography

### M4 — Refinements
- [ ] Syntax highlighting (Shiki themes)
- [ ] `sitemap.xml`
- [ ] `robots.txt`
- [ ] Open Graph / Twitter cards

### M5 — Deploy & CI
- [ ] CI workflow (`npm ci`, `astro build`, deploy `dist/`)
- [ ] Connect to a static host

## Definition of Done

- `npm run build` succeeds with no warnings
- `npm run preview` serves a working static site
- Search at `/search` returns results
- Dark mode works
- Blog listing and individual posts render correctly
- Deployable to a static host (no server-side logic required)

## Open decisions

- [ ] Nav structure: flat list or nested (dropdowns)?
- [ ] Post sorting: date desc by default? Allow sticky?
- [ ] Comments: deferred

---

*Last updated: 2026-11-14*
