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
    :move(x, y, duration)                       -- Animate move
    :moveOffset(x, y, duration)                 -- Animate offset
    :size(w, h, duration)                       -- Animate size
    :morphText(property, targetText, duration)  -- Animate text
    :typewrite(property, targetText, duration)  -- Animate text
    :fadeText(property, targetText, duration)   -- Animate text
    :scrollText(property, targetText, duration) -- Animate text
```

### Animation Control
```lua
local anim = element:animate()
    :moveOffset(5, 0, 1)
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
    :move(10, 5, 1)     -- These three animations
    :size(5, 5, 1)         -- all start and play
    :morphText("text", "newText" 1)  -- simultaneously
    :start()

-- With sequences (animations play one after another):
element:animate()
    :move(10, 5, 1)     -- Plays first
    :sequence()
    :size(5, 5, 1)         -- Starts after position completes
    :sequence()
    :morphText("text", "newText" 1)  -- simultaneously
    :start()
```

### Advanced Usage
```lua
-- Complex movement pattern
element:animate()
    :move(10, 5, 0.5)   -- Move right
    :sequence()
    :move(10, 10, 0.5)  -- Then down
    :sequence()
    :move(5, 10, 0.5)   -- Then left
    :sequence()
    :move(5, 5, 0.5)    -- Then up
    :onDone(function()
        -- Called when entire sequence completes
    end)
    :start()

-- Mixing simultaneous and sequential animations
element:animate()
    -- These two happen together
    :move(10, 5, 1)
    :morphText("text", "newText" 1)  -- simultaneously
    :sequence()
    -- These two also happen together, but after the first group
    :move(5, 5, 1)
    :morphText("text", "anotherText" 1)  -- simultaneously
    :start()
```

### Callbacks
```lua
element:animate()
    :moveOffset(5, 0, 1)
    :onStart(function() end)     -- When animation starts
    :onDone(function() end)      -- When animation completes
    :onStep(function() end)      -- Every animation step
    :start()
```

## Tips & Best Practices
- Use sequences for complex animations
- Keep duration times reasonable (0.1-2 seconds)
- Consider using callbacks for state management