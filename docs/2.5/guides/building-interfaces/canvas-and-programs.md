# Canvas and Hosted Programs

This topic is now split into two focused guides:

- [Canvas](./canvas) — draw custom surfaces owned by the Basalt application.
- [Hosted Programs](./hosted-programs) — embed a complete CC program with its
  own terminal and event loop.

## Which One Do I Need?

Choose Canvas when:

- the model already belongs to your Basalt application;
- you need custom cells, charts, maps, editors, or heatmaps;
- input should directly modify the same model that is drawn.

Choose Program when:

- the child is already a complete terminal application;
- it needs `term`, `os.pullEvent()`, timers, or its own redirects;
- the host should control focus, size, lifecycle, and error handling.

Do not recreate a complete terminal API inside Canvas. Do not launch a
separate program when a small draw callback is enough.

## Continue

- Start with [Canvas](./canvas).
- Continue with [Hosted Programs](./hosted-programs).
- Use [Performance Tuning](../development/performance-tuning) for dense or
  frequently changing surfaces.
