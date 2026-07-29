# Guides

These guides teach the practical side of building CC:Tweaked interfaces
with Basalt 2.5. They focus on complete tasks and the ideas behind them.
For exhaustive property and method lists, use the
[API Reference](/api/).

## Start Here

- [Getting Started](./getting-started) — install Basalt and build a small
  interactive application.
- [Migration Quickstart](./migration-quickstart) — port an ordinary
  application one working screen at a time.
- [Migration Reference](./migrating-from-basalt-2) — look up detailed
  mappings for plugins, layout, state, XML, themes, and removed systems.

## Foundations

Read these guides in order when learning Basalt:

1. [Installation](./foundations/installation) — choose a build, install it,
   and verify your setup.
2. [How Basalt Works](./foundations/mental-model) — understand frames,
   element trees, rendering, and the event loop.
3. [Elements and Properties](./foundations/elements-and-properties) — create,
   configure, find, hide, disable, and remove elements.
4. [Events and Focus](./foundations/events-and-focus) — respond to mouse and
   keyboard input.
5. [Layout Basics](./foundations/layout-basics) — combine fixed sizes with
   `auto`, `fill`, and percentage-based sizing.
6. [Flex Layouts](./foundations/flex-layouts) — build rows, columns, toolbars,
   sidebars, and resizable application shells.
7. [Reactive State](./foundations/reactive-state) — connect application data
   to the interface with signals, computed values, and bindings.
8. [Styling, States, and Themes](./foundations/styling-states-and-themes) —
   use RGB colors, interaction states, reusable defaults, presets, and
   external theme files.

## Building Interfaces

- [Text Inputs](./building-interfaces/text-inputs) — handle one-line and
  multiline editing, events, Enter, and focus.
- [Form Controls and Validation](./building-interfaces/form-controls-and-validation)
  — combine toggles, sliders, reactive values, validation, and submission.
- [Lists and Selection](./building-interfaces/lists-and-selection) — manage
  visible rows, scrolling, selection, activation, and multiple selection.
- [Dropdowns and Suggestions](./building-interfaces/dropdowns-and-suggestions)
  — build compact fixed choices and editable suggestion fields.
- [Tables and Trees](./building-interfaces/tables-and-trees) — present,
  sort, filter, select, and navigate tabular and hierarchical data.
- [Page Navigation](./building-interfaces/page-navigation) — switch
  persistent application pages and manage route focus.
- [Tabs](./building-interfaces/tabs) — organize related views inside one
  persistent panel.
- [Feedback and Progress](./building-interfaces/feedback-and-progress) — show
  inline status, Toast notifications, and determinate progress.
- [Dialogs and Context Menus](./building-interfaces/dialogs) — interrupt a
  workflow for decisions, prompts, or temporary actions.
- [Canvas](./building-interfaces/canvas) — paint dense custom surfaces.
- [Hosted Programs](./building-interfaces/hosted-programs) — run complete CC
  programs inside a Basalt interface.
- [Multiple Roots and Monitors](./building-interfaces/multiple-roots-and-monitors)
  — coordinate terminal and monitor UI trees through one event loop and a
  shared application model.

## Optional Modules

- [Using Optional Modules](./modules/) — choose and load only the features an
  application needs.
- [Animation and Responsive Layouts](./modules/animation-and-responsive) —
  tween properties and apply breakpoint styles.
- [Charts, Images, and BigFont](./modules/charts-images-and-bigfont) —
  visualize data, load assets, and display large text.

## Application Recipes

- [Control Room Dashboard](./recipes/control-room-dashboard) — combine a
  shared data model, persistent pages, a sortable table, reactive settings,
  dialogs, toasts, and scheduled chart updates in one complete application.

## XML

- [XML Interfaces](./xml/) — understand Basalt's XML subset, element mapping,
  attributes, handler scopes, reactive expressions, and limitations.
- [Building Interfaces with XML](./xml/building-with-xml) — build, connect,
  populate, reload, and test a complete file-backed interface.

## Development

- [Interactive Examples](./development/interactive-examples) — run Basalt and
  CC:Tweaked examples directly in the browser.
- [Debugging](./development/debugging) — inspect live interfaces and
  understand error screens.
- [Testing](./development/testing) — assert state, focus, hit testing, and
  event routing without a blocking loop.
- [Performance Tuning](./development/performance-tuning) — measure realistic
  updates, understand invalidation and line-based flushing, and reduce layout,
  rendering, and reactive work.

## Guide Coverage

The planned core guide path is complete. Future additions can focus on
project-specific recipes, persistence, networking, and deployment patterns.

The guide set follows the current Basalt 2.5 source. Documentation for the
frozen Basalt 2 release remains available in the
[Basalt 2 documentation](https://basalt.madefor.cc/2.0/).
