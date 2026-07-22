# Testing Learning Plan — React & Laravel

A step-by-step roadmap to go from zero to confidently **directing agents** and **reviewing tests**.

Apply this plan in **your application repo** (not this craft repo). Install tooling there; check items off as you go.

**Default stack in these notes:** React + Inertia + TypeScript (frontend) and Laravel + Pest (backend).  
Swap packages/paths if your stack differs (e.g. Vue, Livewire, plain PHPUnit).

---

## Why this order (frontend first)

Start where the UI lives so you learn the core idea early — **test behavior, not implementation** — then reuse that mindset on Laravel.

Each part ends with a short “how to judge a test” checklist. The goal is fluency in *reviewing* tests, not only writing them.

---

## How to use this plan

- Work through one phase at a time.
- Prefer the **why** before the **how**.
- Adapt examples (paths, auth packages, UI libs) to your app.
- Optional extras below are marked — skip them if you don’t use that library.

---

## Vocabulary to own

- [ ] **Unit test** — one function/component in isolation
- [ ] **Integration test** — several pieces working together
- [ ] **Feature / E2E test** — a full user flow
- [ ] **Test double** — umbrella for **mock, stub, spy, fake**
- [ ] **Arrange–Act–Assert (AAA)** — the 3-part shape of every test
- [ ] **Assertion** — the check that decides pass/fail
- [ ] **Fixture / factory** — reusable test data
- [ ] **Coverage** — % of code executed (a signal, not a target)
- [ ] **Flaky test** — passes/fails randomly; the enemy
- [ ] **Regression test** — added after a bug fix so it never returns

---

# PART 1 — Frontend Testing (React + TypeScript)

### Packages & why

- [ ] **Vitest** — test runner, natural fit with Vite
- [ ] **@testing-library/react** — test like a user (query by role/text)
- [ ] **@testing-library/jest-dom** — readable matchers (`toBeInTheDocument()`)
- [ ] **@testing-library/user-event** — realistic user interactions
- [ ] **jsdom** — fake browser DOM for Node
- [ ] **msw** *(optional)* — mock APIs at the network layer (handy with TanStack Query or similar)

## Phase 1 — Foundations

- [ ] Install & configure Vitest in your app
- [ ] Write first assertion (`expect(1 + 1).toBe(2)`)
- [ ] Test a pure util/formatter (e.g. under `resources/js` in a Laravel + Vite app)
- [ ] Learn: `describe`, `it`/`test`, `expect`, matchers, `beforeEach`
- [ ] ✅ Outcome: explain what a runner does; structure any test with AAA

## Phase 2 — Component testing

- [ ] Test a presentational component (button, badge, or similar)
- [ ] Learn queries: `getByRole`, `getByText`, `findBy*`, `queryBy*`
- [ ] Understand `getBy` vs `queryBy` vs `findBy` (throws / null / async)
- [ ] Use `user-event` to click/type and assert results
- [ ] ✅ Outcome: test any component’s output and interactions

## Phase 3 — Interactive & async components

- [ ] Test a form component with validation states
- [ ] *(If you fetch client-side)* Add **MSW**; mock a data-fetching component
- [ ] Cover loading, success, and error states
- [ ] Learn `waitFor` / `findBy`; never assert on internal state
- [ ] ✅ Outcome: confidently test async UI

## Phase 4 — Inertia-aware testing *(skip if you don’t use Inertia)*

- [ ] Mock `@inertiajs/react` (`<Link>`, `useForm`, page props)
- [ ] Test a real page from your pages directory (e.g. `resources/js/pages`)
- [ ] ✅ Outcome: test Inertia pages in isolation

### ✅ Judge-a-test checklist (frontend)

- [ ] Queries by role/text (user perspective), not CSS classes
- [ ] Survives a behavior-preserving refactor (not brittle)
- [ ] Covers relevant async states (loading / error / success)
- [ ] Network mocked at the boundary (e.g. MSW), not deep internals

---

# PART 2 — Backend Testing (Laravel)

### Packages & why

- [ ] **Pest** (`pestphp/pest`) — modern Laravel default, built on PHPUnit
- [ ] **PHPUnit** — comes underneath Pest; learn its assertions & `TestCase`
- [ ] Built-in helpers — `RefreshDatabase`, HTTP tests, `assertDatabaseHas`, factories (no extra install)

## Phase 5 — Laravel foundations

- [ ] Install Pest; run the example test
- [ ] Learn `RefreshDatabase` + in-memory SQLite (isolated, fast)
- [ ] Use model factories (`database/factories`) and seeders
- [ ] ✅ Outcome: understand the test lifecycle & data setup

## Phase 6 — Feature tests / HTTP

- [ ] Test a controller: `assertOk`, `assertRedirect`, `assertDatabaseHas`
- [ ] Test authentication with `actingAs($user)` (or your auth package)
- [ ] *(If you use roles/permissions)* Test authorization (e.g. Spatie Permission)
- [ ] ✅ Outcome: test routes, auth, and access rules end to end

## Phase 7 — Validation, unit & Inertia assertions

- [ ] Test form request validation (`assertSessionHasErrors`)
- [ ] Write a true unit test for a service/action class (no DB)
- [ ] *(If you use Inertia)* Use `assertInertia` to verify correct page + props
- [ ] ✅ Outcome: connect both halves of the stack

### ✅ Judge-a-test checklist (backend)

- [ ] Asserts observable outcomes (response, DB, session), not method calls
- [ ] Covers auth/permissions on protected routes
- [ ] Sets up its own data via factories (no hidden shared state)
- [ ] Fast & isolated (`RefreshDatabase`, no real external calls)

---

# PART 3 — Leading Agents (the payoff)

- [ ] Write a precise test-request prompt (behavior, edge cases, what NOT to mock)
- [ ] Review agent-generated tests against both checklists above
- [ ] Spot smells: over-mocking, testing implementation, snapshot-everything, no edge cases, flaky async
- [ ] Wire tests into your CI or local check script so the suite runs reliably

---

## Final deliverables

- [ ] Working Vitest + Testing Library setup in **your** app (MSW if you need it)
- [ ] A Pest suite with feature + unit examples
- [ ] Two mental checklists for judging any test
- [ ] Fluency in common testing vocabulary

---

### Decisions in these notes (idiomatic defaults)

- **Vitest over Jest** — natural fit with Vite
- **Pest over raw PHPUnit** — Laravel’s modern default (you still learn PHPUnit underneath)

Change either choice if your team already standardized on something else.
