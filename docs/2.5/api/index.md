# API Reference

This reference is generated from the current Basalt 2.5 source comments.
Use the [Guides](/guides/) for task-oriented explanations and this section
when you need exact properties, events, parameters, or return values.

## Where to Start

- [`basalt`](./basalt) — root Frames, state, layout tokens, scheduling, updates,
  and the application event loop.
- [`Element`](./elements/Element) — shared geometry, visibility, styling, state,
  focus, events, bindings, and invalidation.
- [`Container`](./elements/Container) — child trees, lookup, scrolling, layout,
  rendering, and event routing.
- [`BaseFrame`](./elements/BaseFrame) — terminal-bound roots and focus ownership.
- [`state`](./core/state) — writable Signals and Computed values.

The sidebar contains every generated core type, element, and optional module.

## Elements

Every element is created through a parent container:

```lua
local button = frame:addButton({
    x = 2,
    y = 3,
    width = 12,
    text = "Save",
})
```

Open the element's page for its own properties and methods. Inherited
behavior remains documented on Element and Container.

Frequently used entries include:

- [`Input`](./elements/Input), [`TextBox`](./elements/TextBox), and
  [`Button`](./elements/Button)
- [`List`](./elements/List), [`Dropdown`](./elements/Dropdown), and
  [`ComboBox`](./elements/ComboBox)
- [`Table`](./elements/Table) and [`Tree`](./elements/Tree)
- [`Canvas`](./elements/Canvas) and [`Program`](./elements/Program)

## Optional Modules

Load a module before using the elements or fluent methods it registers:

```lua
local animation = basalt.use("animation")
```

See the Modules section in the sidebar for animation, responsive layouts,
charts, images, BigFont, themes, XML, and debugging.
