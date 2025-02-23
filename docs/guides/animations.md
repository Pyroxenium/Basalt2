# Basalt Animations

Basalt provides a powerful animation system that allows you to create smooth transitions and effects for UI elements.

## Basic Concepts

Animations in Basalt work with:
- **Sequences**: Groups of animations that play one after another
- **Chains**: Multiple sequences that can be controlled together
- **Timing**: Control over duration and easing of animations

`element:animate()` creates a new Animation object. Each animation method accepts a duration parameter (in seconds).

### Core Animation Methods
```lua
element:animate()
    :offset(x, y, duration)       -- Animate offset
    :size(w, h, duration)         -- Animate size
    :position(x, y, duration)     -- Animate position
    :textColor(color, duration)   -- Animate text color
    :background(color, duration)  -- Animate background color
```

### Animation Control
```lua
local anim = element:animate()
    :offset(5, 0, 1)
    :start()                     -- Start the animation

anim:pause()                     -- Pause animation
anim:resume()                    -- Resume animation
anim:stop()                      -- Stop animation
```

## Understanding Sequences

Sequences allow you to create complex animations by controlling when each animation plays. By default, all animations in a chain play simultaneously. Using `:sequence()` creates a new group that waits for the previous animations to complete.

### Basic Example
```lua
-- Without sequences (animations play at the same time):
element:animate()
    :position(10, 5, 1)     -- These three animations
    :size(5, 5, 1)         -- all start and play
    :background(colors.red, 1)  -- simultaneously
    :start()

-- With sequences (animations play one after another):
element:animate()
    :position(10, 5, 1)     -- Plays first
    :sequence()
    :size(5, 5, 1)         -- Starts after position completes
    :sequence()
    :background(colors.red, 1)  -- Starts after size completes
    :start()
```

### Advanced Usage
```lua
-- Complex movement pattern
element:animate()
    :position(10, 5, 0.5)   -- Move right
    :sequence()
    :position(10, 10, 0.5)  -- Then down
    :sequence()
    :position(5, 10, 0.5)   -- Then left
    :sequence()
    :position(5, 5, 0.5)    -- Then up
    :onDone(function()
        -- Called when entire sequence completes
    end)
    :start()

-- Mixing simultaneous and sequential animations
element:animate()
    -- These two happen together
    :position(10, 5, 1)
    :background(colors.blue, 1)
    :sequence()
    -- These two also happen together, but after the first group
    :position(5, 5, 1)
    :background(colors.red, 1)
    :start()
```

### Callbacks
```lua
element:animate()
    :offset(5, 0, 1)
    :onStart(function() end)     -- When animation starts
    :onDone(function() end)      -- When animation completes
    :onStep(function() end)      -- Every animation step
    :start()
```

## Tips & Best Practices
- Use sequences for complex animations
- Keep duration times reasonable (0.1-2 seconds)
- Consider using callbacks for state management