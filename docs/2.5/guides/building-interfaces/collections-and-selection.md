# Collections and Selection

Collection controls share the same item, selection, and activation model, but
their interaction patterns differ. The detailed material is now split into:

- [Lists and Selection](./lists-and-selection) — visible rows, scrolling,
  keyboard navigation, activation, and multiple selection.
- [Dropdowns and Suggestions](./dropdowns-and-suggestions) — compact
  Dropdown choices and editable ComboBox suggestions.

## Quick Choice

| Control | Use it for |
| --- | --- |
| List | Several visible rows or multi-selection |
| Dropdown | One value chosen from a fixed set |
| ComboBox | Editable text with optional suggestions |
| Table | Structured rows with several columns |
| Tree | Hierarchical data |

All collection controls distinguish selection from activation:

- `change` reports selection movement;
- `select` reports acceptance or activation.

## Continue

Start with [Lists and Selection](./lists-and-selection), then use
[Dropdowns and Suggestions](./dropdowns-and-suggestions) for compact form
controls. See [Tables and Trees](./tables-and-trees) for structured data.
