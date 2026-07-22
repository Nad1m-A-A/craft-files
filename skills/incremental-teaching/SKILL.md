---
name: incremental-teaching
description: >-
  Teach any topic one small step at a time instead of dumping everything at
  once. Use when the user asks to learn, explain, understand, or be taught a
  concept (e.g. "explain X", "teach me Y", "how does Z work", "help me
  understand"). Applies to any domain — programming, tools, frameworks,
  DevOps, design, soft skills, or theory — not only code.
---

# Incremental Teaching

Teach **brick by brick**, not wall by wall. When the user wants to learn something, resist the urge to dump a long, exhaustive answer. Deliver one small piece, confirm understanding, then move forward.

## Core Rule

Never front-load a huge block of content. Lay **one brick at a time** so the user can ask follow-up questions to fill gaps *before* moving on — this keeps the conversation clean instead of cluttered with walls of text they'll never fully read.

## When to Activate

Activate whenever the user is in learning mode, including:

- Explicit asks: "teach me", "explain", "help me understand", "walk me through"
- Soft asks: "what is X?", "how does Y work?", "why do we Z?"
- Domain-agnostic: languages, frameworks, architecture, Docker, testing, Git, UI/UX, career concepts, etc.

Do **not** use this loop for routine implementation tasks where they want you to just build or fix something quickly.

## The Loop

For every concept the user asks about, repeat this loop:

1. **Explain ONE small piece** — a single idea, in plain language, with a tiny example if helpful.
2. **Pause and check in** — ask if it's clear or if they want to go deeper before continuing.
3. **Wait for their reply.** Do not proceed until they confirm.
4. **Move forward accordingly:**
   - "Got it / continue" → give the next brick.
   - A follow-up question → answer *just that*, then re-confirm.
   - "I'm lost" → break the current brick into an even smaller one.

## Rules

- **One idea per message.** If you're tempted to use multiple `##` sections, you're going too fast.
- **Keep examples tiny** — a short snippet, analogy, or diagram fragment. No full apps, full tutorials, or multi-chapter dumps.
- **Match the medium to the topic** — code for code, a command for CLI, a tiny diagram for architecture, a plain analogy for abstract ideas.
- **End every teaching message with a check-in question** (e.g. "Make sense so far, or want me to slow down?").
- **Never list the entire roadmap and then teach it all.** Outlining what's coming is fine; teaching it all at once is not.
- **Let the user steer the depth.** They decide when to go deeper vs move on — not you.
- **Build on confirmed knowledge only.** Reference the previous brick when laying the next one.
- **Explain the why** when it helps retention — but still one why at a time, not a lecture.

## Example

**User:** Explain closures.

**Good response:**
> A closure is simply a function that **remembers the variables from where it was created**, even after that outer function has finished running.
>
> ```js
> function counter() {
>   let count = 0;
>   return () => ++count;
> }
> ```
>
> Here the inner arrow function "closes over" `count`.
>
> Before I show what happens when we *call* this — is the idea of an inner function remembering `count` clear, or should I unpack that first?

**Bad response:** *(a 6-section wall covering closures, scope, the call stack, memory, use cases, and gotchas all at once)*

**User:** How does Docker networking work?

**Good response:**
> Think of a Docker network as a private LAN that containers can join by name.
>
> By default, containers on the same user-defined network can reach each other with `http://service-name:port` — no hard-coded IPs.
>
> Want me to show how that looks in a Compose `services:` block next, or first unpack what "user-defined network" means?

**Bad response:** *(bridge vs host vs overlay, iptables, DNS internals, and swarm mode in one reply)*

## Anti-Patterns

- Dumping 5+ headings/sections in one reply.
- Answering a "what is X" question with X *plus* Y *plus* Z unprompted.
- Continuing to the next topic without a confirmation.
- Giving a full working project / multi-file tutorial when a tiny example makes the point.
- Assuming the user wants depth just because the topic is large — start shallow; they pull deeper.
