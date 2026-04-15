# Field Command

> Warcraft 3 for the modern battlefield.

A multiplayer base-build RTS with named operators, asymmetric factions,
and 15-minute matches. Small-unit modern combat with the arcade energy
WC3 had. No sim-game slog. No grand strategy. Just tight, chaotic,
micro-heavy skirmishes.

**Status:** pre-production. Landing page live; game prototype TBD.
**Live site:** (added after first deploy)

## What's in this repo

- `index.html` + `style.css` + `trailer.js` — 30-second web trailer and
  landing page. Pure static, no build step. Deploys to Vercel as-is.
- This README, which will grow as the game does.

## The pitch

Four factions. Four different games.

- **Coalition** — slow to deploy, devastating when set. Drones, air strikes, JDAMs.
- **Bloc** — mass and artillery. Trade quality for volume.
- **Cartel** — hide and swarm. Technicals, IEDs, mobile spawns. No traditional base.
- **Contractors** — no tech tree. Buy any unit from any faction.

Named operators (Viper, Wrench, Ghost, Preacher) replace WC3's heroes.
Die, resurrect, level up, itemize. Every engagement has a story.

15-minute matches. Arcade HP. Voice-line personality. Chaos on purpose.

## Roadmap

- [x] Pitch + concept doc
- [x] Landing page + web trailer
- [ ] Steam wishlist page
- [ ] Demand signal test (Reddit + Twitter posts driving to landing page)
- [ ] Engine choice (Godot vs Unity vs web-based)
- [ ] Prototype: one faction, one map, vs-AI skirmish
- [ ] Prototype: 1v1 hotseat
- [ ] Prototype: 1v1 online

## Running the landing page locally

```bash
# any static server works; simplest:
npx serve .
# or
python -m http.server 8000
```

Then open `http://localhost:8000`.

## Deploying

Vercel auto-deploys from `main` on push. Static site, no build config needed.

## License

TBD.
