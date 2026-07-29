# Debugging and Testing

This material is now split by purpose:

- [Debugging](./debugging) — inspect a live interface, log transitions,
  understand focus and geometry, and diagnose error screens.
- [Testing](./testing) — assert domain logic, Signals, event routing, focus,
  and rendering with non-blocking updates.

## Recommended Workflow

1. Reproduce and inspect the problem with the debug overlay.
2. Reduce it to the smallest relevant tree.
3. Fix the cause.
4. Preserve the expected behavior with a deterministic test.

Use [Interactive Examples](./interactive-examples) when a reduced case should
also be runnable in the browser.
