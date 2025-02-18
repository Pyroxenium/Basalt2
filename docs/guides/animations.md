# Basalt Animations

Basalt provides a powerful animation system that allows you to create smooth transitions and effects for UI elements.

## Basic Concepts

Animations in Basalt work with:
- **Sequences**: Groups of animations that play one after another
- **Chains**: Multiple sequences that can be controlled together
- **Timing**: Control over duration and easing of animations

## Available Animations

### Movement
```lua
element:animate()
    :move(x, y, duration)    -- Moves to new position
```

### Visual Effects
```lua
element:animate()
    :size(width, height, duration)
```

### Text Animations
```lua
element:animate()
    :typewrite(property, text, duration) -- Typing effect
    :text(text, duration)               -- Instant text change
```

## Animation Control

Control your animations using these methods:
```lua
local anim = element:animate()
    :move(10, 5, 1)
    :start()

anim:pause()    -- Pause animation
anim:resume()   -- Resume animation
anim:stop()     -- Stop animation
anim:cancel()   -- Cancel animation
```

## Sequences

Chain multiple animations together:
```lua
element:animate()
    :move(10, 5, 1)        -- First sequence
    :sequence()            -- Start new sequence
    :move(20, 5, 1)       -- Plays after first sequence
    :sequence()
    :background(colors.red, 0.5)
    :start()
```

## Event Handling

Animations support various events:
```lua
element:animate()
    :move(10, 5, 1)
    :onStart(function() 
        -- Called when animation starts
    end)
    :onDone(function() 
        -- Called when animation completes
    end)
    :start()
```

## Tips & Best Practices

- Use sequences for complex animations
- Keep animations short and responsive
- Consider using events for coordinating multiple animations
- Test animations on different computer tiers