# Claude Code Guidelines

## Workflow (after every Python change)

```bash
just fmt && just lint && just typecheck && just test && just qa_guard
```
- Fix failures immediately before moving on. No "fix later" — leave every file better than you found it.
- Let Xenon guide design: if complexity creeps up, that's a signal to simplify, not to raise the threshold.
- If a test is hard to write, the code is too complex — simplify the design, not the test.
- New package: `uv add <pkg> && uv sync --all-groups`.
- Complexity budget: Xenon max-absolute/modules/average = A.
- Keep documentation in sync with every change. `README.md` contains: a one-line description of what the package does, how to set up and work with the project (commands, structure, CI/CD), and a pointer to `just docs` for full documentation. `docs/` contains all functional documentation — domain concepts, behaviour, and design decisions. Never put functional detail in the README beyond the one-liner.
- When the user comments on approach, style, or decisions: treat it as a signal to propose a CLAUDE.md update. Evolve the guidelines to reflect the working relationship.

## Style

**Paradigm:** Functional core, imperative shell — pure functions transform data, side effects at the edges. OOP only for stateful/identity-bearing objects; plain functions for transformations.

**Pythonic:** Prefer comprehensions, generators, context managers. Reach for `itertools`/`functools`/`contextlib` before rolling your own.

**Functions:** Prefer small and single-purpose, but don't split when locality makes the whole easier to follow. Judge; if unsure, ask.

**Structure:** Chunk code by concept — a name and blank line should convey the intent before reading the body. Make relationships between chunks visible.

**Architecture:** Organise by feature/concept (vertical slices), not by technical layer. A slice owns everything it needs — keep related behaviour together rather than splitting it across `models/`, `services/`, `utils/`. A reader should be able to follow a concept without jumping across the codebase.

**Naming:** Natural language order (`maximum_score`, `is_valid_token`) — never inverted (`score_max`). One consistent mould per concept. Full words unless the abbreviation is universal (`url`, `id`). Use domain language exactly — if the domain says `commit_message`, don't say `text`. If unsure about a name, ask. Names are the primary way a reader chunks code — a wrong name forces line-by-line reading and introduces bugs. Enforce: `is_*` returns bool, `get_*` has no side effects, `maximum_*` holds a maximum. A function must do exactly what its name says — no more, no less.

**Cognitive load:** Keep functions within what can be held in mind at once (~6 moving parts). Avoid long parameter lists, deep nesting, and scattered logic that forces jumping across files to form a picture. Keep related things together.

**Docstrings:** Required on all functions. One line, explain intent (*why*) not mechanics (*what*). No args/returns sections — less is more.

**Comments:** Intent and reasoning behind non-obvious choices only — never restate the code.

**Zen of Python (applied):**
- Explicit over implicit — no magic, no surprise behaviour.
- Simple over complex; complex over complicated — add a layer only when it genuinely reduces total complexity.
- Flat over nested — restructure before you indent deeper.
- Sparse over dense — one idea per line; whitespace is not wasted space.
- Readability counts — if it is hard to explain, the design is wrong.
- Errors should never pass silently — surface them, type them, handle them deliberately.
- Refuse the temptation to guess — when intent is ambiguous, ask.
- One obvious way to do it — if you find yourself weighing three equivalent approaches, pick the most conventional one.

## TDD

1. Write the test first; show the user and wait for approval.
2. Run it — confirm it fails for the right reason (real assertion, not import error).
3. Write the minimum implementation to pass. Run the pipeline. Move on.
4. Never edit tests and implementation together — one file at a time so regressions are attributable.
- Fast, meaningful, regression-protecting, easy to reason about — every test must earn its place.
- No mocks except at IO boundaries (filesystem, network, subprocess). Prefer real objects and fakes.
- Parameterise when the same assertion covers multiple inputs.
- Locality over DRY: repeat setup rather than abstracting it away. Tests must be readable in isolation.
- Abstract shared *utilities* (builders, fakes) — never shared *assertions*.
