# animation

Animation module: tweens numeric properties over time.

  local anim = basalt.use("animation")
  anim.to(label, { x = 20, y = 5 }, 0.5, "easeOut", function(el) ... end)
  label:animate({ x = 20 }, 0.5)          -- sugar added to Element

Standalone module: drives itself through a basalt.schedule coroutine
(sleep-based, ~20 fps) and touches no core files.

## Methods

### animation.to(el, props, duration, easing, onDone)

Tweens the given numeric properties to their target values.

- **el** (`table`) The element to animate
- **props** (`table`) Target values, e.g. { x = 20, y = 5 }
- **duration** (`number|nil`) Seconds, default 0.3
- **easing** (`string|nil`) "linear", "easeIn", "easeOut" or "easeInOut"
- **onDone** (`function|nil`) Called with the element after completion

- **returns** **handle** (`table`) Handle with :cancel()

### Element:animate(props, duration, easing, onDone)

Sugar on Element: el:animate({x = 20}, 0.5, "easeOut", onDone)
Fluent element shortcut for animation.to().

- **props** (`table`) Target property values
- **duration** (`number|nil`) Seconds, default 0.3
- **easing** (`string|nil`) Easing name
- **onDone** (`function|nil`) Completion callback

- **returns** **handle** (`table`) Cancellable animation handle
