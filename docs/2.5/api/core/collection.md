# collection

## Types

### `CollectionItem`

Data accepted by collection-like elements when creating an entry.

| Field | Type | Description |
| --- | --- | --- |
| text *(optional)* | `string` | Display text |
| label *(optional)* | `string` | Fallback display text when text is omitted |
| value *(optional)* | `any` | Item value and final fallback display text |
| callback *(optional)* | `fun(collection: CollectionMixin, item: CollectionEntry\|CollectionItem)` | Called when the item is activated |
| selectable *(optional)* | `boolean` | Whether the entry can be selected |
| disabled *(optional)* | `boolean` | Whether the entry is disabled |
| separator *(optional)* | `boolean` | Whether the entry is rendered as a separator |
| selected *(optional)* | `boolean` | Whether the entry should initially be selected |
| fg *(optional)* | `number` | Foreground color |
| bg *(optional)* | `number` | Background color |
| selectedFg *(optional)* | `number` | Foreground color while selected |
| selectedBg *(optional)* | `number` | Background color while selected |
| iconChar *(optional)* | `string\|number` | Optional single-cell icon |
| iconX *(optional)* | `number` | Horizontal icon position |
| iconForeground *(optional)* | `number` | Icon foreground color |
| iconBackground *(optional)* | `number` | Icon background color |
| selectedIconForeground *(optional)* | `number` | Icon foreground color while selected |
| selectedIconBackground *(optional)* | `number` | Icon background color while selected |
| items *(optional)* | `(CollectionItem\|string)[]` | Submenu items |
| dropdown *(optional)* | `(CollectionItem\|string)[]` | Alias for submenu items |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| select | :onSelect(fn) | Fired on item selection with (index, item) |

## Methods

### collection.install(c, options)

Installs the shared collection properties, events and methods on a class.

- **c** (`table`) Target element class
- **options** (`{ changeEvent?: string|false }`, optional) Mixin options

### collection.setup(self)

Initializes per-instance state and input handlers.

- **self** (`CollectionMixin`) Collection-like element

### CollectionMixin:indexOfItem(value)

Resolves an item value or index to its current index.

- **value** (`integer|CollectionEntry`) Item index or entry

- **returns** **index** (`integer|nil`) The index, or nil if not found

### CollectionMixin:getItem(index)

Returns one normalized entry by index.

- **index** (`integer`) Item index

- **returns** **entry** (`CollectionEntry|nil`) 

### CollectionMixin:getItemCount()

Returns the number of collection entries.

- **returns** **count** (`integer`) 

### CollectionMixin:addItem(item)

Appends an item (string, table with text/fg/bg/callback, or entry).

- **item** (`CollectionItem|string|CollectionEntry`) The item to add

- **returns** **entry** (`CollectionEntry`) The normalized collection entry

### CollectionMixin:insertItem(index, item)

Inserts an item at a position (clamped to the valid range).

- **index** (`number`) Target position
- **item** (`CollectionItem|string|CollectionEntry`) The item to insert

- **returns** **entry** (`CollectionEntry`) The normalized collection entry

### CollectionMixin:removeItem(value)

Removes an item by value or index; selection is kept consistent.

- **value** (`integer|CollectionEntry`) Item index or entry

- **returns** (`self`) 

### CollectionMixin:clear()

Removes all entries and clears selection.

- **returns** (`self`) 

### CollectionMixin:clearItems()

Alias for clear().

- **returns** (`self`) 

### CollectionMixin:isItemSelected(value)

Tests whether an entry or index is selected.

- **value** (`integer|CollectionEntry`) Item index or entry

- **returns** **selected** (`boolean`) 

### CollectionMixin:isSelected(value)

Basalt 2 compatibility alias for isItemSelected().

- **value** (`integer|CollectionEntry`) Item index or entry

- **returns** **selected** (`boolean`) 

### CollectionMixin:getSelectedItems()

Returns all selected entries in display order.

- **returns** **entries** (`CollectionEntry[]`) List of selected collection entries

### CollectionMixin:getSelectedItem()

Returns the first selected entry.

- **returns** **entry** (`CollectionEntry|nil`) 

### CollectionMixin:getSelectedIndex()

Returns the first selected entry's current index.

- **returns** **index** (`integer|nil`) 

### CollectionMixin:getSelection()

Returns all selected indices in ascending order.

- **returns** **indices** (`integer[]`) 

### CollectionMixin:selectItem(value, emit)

Selects an item (adds to the selection when multiSelection is on).

- **value** (`integer|CollectionEntry`) Item index or entry
- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:unselectItem(value, emit)

Removes an entry from selection.

- **value** (`integer|CollectionEntry`) Item index or entry
- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:toggleItem(value, emit)

Toggles an item's selection state.

- **value** (`integer|CollectionEntry`) Item index or entry
- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:clearItemSelection(emit)

Clears all selected entries.

- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:clearSelection(emit)

Alias for clearItemSelection().

- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:selectNext(emit)

Selects the next selectable entry after the current selection.

- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:selectPrevious(emit)

Selects the previous selectable entry before the current selection.

- **emit** (`boolean|nil`) false suppresses the change event

- **returns** (`self`) 

### CollectionMixin:scrollToTop()

Scrolls a collection view to its first item when supported.

- **returns** (`self`) 

### CollectionMixin:scrollToBottom()

Scrolls a collection view to its final item when supported.

- **returns** (`self`) 

### CollectionMixin:activateItem(value, emit, toggle)

Selects an item AND fires its callback plus the select event
(what a mouse click or the enter key does).

- **value** (`integer|CollectionEntry`) Item index or entry
- **emit** (`boolean|nil`) false suppresses callback and select event
- **toggle** (`boolean|nil`) true toggles instead of selecting

- **returns** (`self`) 

### CollectionMixin:select(value, emit)

Selects and optionally activates an entry.

- **value** (`integer|CollectionEntry`) Item index or entry
- **emit** (`boolean|nil`) false suppresses callback/select event

- **returns** (`self`) 
