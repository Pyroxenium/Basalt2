# state

Reactive application state for Basalt 2.

Signals are ordinary values outside the UI. When read through an element
property they remember that element weakly; changing the signal then marks
every dependent UI tree dirty. Computed values collect these dependencies
implicitly while their function runs.

## Types

### `StateListener<T>`

```lua
StateListener<T> = fun(value: T, oldValue: T?)
```

### `StateUnsubscribe`

```lua
StateUnsubscribe = fun()
```

### `Signal<T>`

### `Computed<T>`

## Methods

### state.clearWatcher(watcher)

Removes dependencies collected during the previous render pass.

- **watcher** (`Element`) Watcher to detach

### state.withWatcher(watcher, fn, ...)

Runs fn while signal reads register watcher as a dependency.

- **watcher** (`Element`, optional) Watcher collecting dependencies
- **fn** (`fun(...: any): ...any`) Function to execute
- **...** (`any`) Arguments forwarded to fn

- **returns** (`...any`) Values returned by fn

### state.is(value)

Tests whether a value is a State or Computed value.

- **value** (`any`) Candidate value

- **returns** **isState** (`boolean`) 

### state.read(value, watcher)

Reads a State or Computed value with optional dependency tracking.

- **value** (`Signal<T>|Computed<T>`) State-like value
- **watcher** (`Element`, optional) Dependent element

- **returns** **value** (`T`) 

### state.isWritable(value)

Tests whether a state-like value supports set/update operations.

- **value** (`any`) Candidate value

- **returns** **writable** (`boolean`) 

### Signal:get(watcher)

Returns the current value and optionally registers a UI watcher.

- **watcher** (`Element`, optional) Dependent element

- **returns** **value** (`T`) 

### Signal:set(value)

Replaces the state value and invalidates dependents.

- **value** (`T`) New value

- **returns** (`self`) 

### Signal:update(fn)

Replaces the value with fn(currentValue).

- **fn** (`fun(value: T): T`) Update function

- **returns** (`self`) 

### Signal:touch()

Notifies dependents after mutating a table value in place.

- **returns** (`self`) 

### Signal:subscribe(fn, immediate)

Subscribes to writes and returns an unsubscribe closure.

- **fn** (`StateListener<T>`) Listener receiving value and oldValue
- **immediate** (`boolean`, optional) Call immediately with the current value

- **returns** **unsubscribe** (`StateUnsubscribe`) 

### Signal:map(fn)

Creates a computed value derived from this state.

- **fn** (`fun(value: T): U`) Mapping function

- **returns** **computed** (`Computed<U>`) 

### Computed:get(watcher)

Evaluates and returns the computed value.

- **watcher** (`Element`, optional) Dependent element

- **returns** **value** (`T`) 

### Computed:map(fn)

Creates another computed value from this one.

- **fn** (`fun(value: T): U`) Mapping function

- **returns** **computed** (`Computed<U>`) 

### state.create(initialValue)

Creates a writable reactive state.

- **initialValue** (`T`) Initial value

- **returns** **state** (`Signal<T>`) 

### state.computed(fn)

Creates a lazily evaluated computed value.

- **fn** (`fun(): T`) Computation function

- **returns** **computed** (`Computed<T>`) 
