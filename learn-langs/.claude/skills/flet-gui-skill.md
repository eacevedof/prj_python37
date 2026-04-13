# Flet GUI Framework Expert Skill

Expert guidance for building desktop, web, and mobile applications with Flet (Python).

## Flet Version Compatibility

This skill targets **Flet 0.80+** (1.0 Beta and later). Major API changes occurred in 0.80.

## Core Concepts

### Application Entry Point (Flet 0.80+)

```python
import flet as ft

async def main(page: ft.Page):
    """Async main function - preferred pattern."""
    page.title = "My App"
    page.window.width = 900
    page.window.height = 700

    # Add controls
    page.add(ft.Text("Hello, Flet!"))

if __name__ == "__main__":
    ft.run(main)  # NOT ft.app() - deprecated
```

**Important**: Use `ft.run()` instead of `ft.app()` (deprecated since 0.80).

### Custom Controls Pattern (Flet 0.80+)

**UserControl is DEPRECATED**. Inherit directly from the appropriate control:

```python
# OLD (deprecated):
class MyComponent(ft.UserControl):
    def build(self):
        return ft.Container(...)

# NEW (correct):
class MyComponent(ft.Container):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self._build_ui()

    def _build_ui(self):
        self.content = ft.Column([...])
        self.expand = True
        self.padding = 20

    def did_mount(self):
        """Called when control is added to page."""
        self.page.run_task(self._load_data)

    def will_unmount(self):
        """Called before control is removed."""
        pass
```

### Common Base Controls for Custom Components

- `ft.Container` - For single-child wrapper components
- `ft.Column` - For vertical layouts
- `ft.Row` - For horizontal layouts
- `ft.Stack` - For overlapping controls
- `ft.Card` - For card-style components

## Event Handlers Reference

### Dropdown
```python
ft.Dropdown(
    label="Select option",
    options=[
        ft.dropdown.Option(key="opt1", text="Option 1"),
        ft.dropdown.Option(key="opt2", text="Option 2"),
    ],
    value="opt1",
    on_select=self._handle_select,  # NOT on_change
)

def _handle_select(self, e):
    selected_value = e.control.value
```

### TextField
```python
ft.TextField(
    label="Name",
    hint_text="Enter your name",
    value="",
    autofocus=True,
    disabled=False,
    on_change=self._handle_change,    # Called on each keystroke
    on_submit=self._handle_submit,    # Called on Enter
    on_focus=self._handle_focus,
    on_blur=self._handle_blur,
)
```

### Chip (for tags/filters)
```python
ft.Chip(
    label=ft.Text("Tag name"),
    selected=False,
    on_select=self._handle_chip_select,  # Toggles selected automatically
    # NOTE: on_click and on_select are mutually exclusive
)

def _handle_chip_select(self, e):
    is_selected = e.control.selected  # Already toggled
```

### Button (Flet 0.84+)
```python
# Simple button
ft.ElevatedButton(
    content=ft.Text("Click me"),
    on_click=self._handle_click,
)

# Button with icon
ft.ElevatedButton(
    content=ft.Row(
        [ft.Icon(ft.Icons.ADD), ft.Text("Add item")],
        alignment=ft.MainAxisAlignment.CENTER,
    ),
    on_click=self._handle_click,
    style=ft.ButtonStyle(
        bgcolor=ft.Colors.BLUE_700,
        color=ft.Colors.WHITE,
    ),
)

# TextButton
ft.TextButton(
    content=ft.Text("Cancel"),
    on_click=self._handle_cancel,
)
```

### ListView
```python
ft.ListView(
    controls=[...],
    expand=True,
    spacing=4,
    padding=10,
    auto_scroll=False,
)
```

## Async Operations

### Running async tasks from sync handlers
```python
def _handle_click(self, e):
    """Sync event handler."""
    self.page.run_task(self._async_operation)

async def _async_operation(self):
    """Async operation."""
    await asyncio.sleep(1)
    # Update UI
    self.some_text.value = "Done!"
    self.update()

# WRONG - lambda returns coroutine, not a coroutine function
# self.page.run_task(lambda: self._async_operation(param))  # TypeError!

# CORRECT - define async function inline
def _handle_with_param(self, param: str):
    async def do_work():
        await self._async_operation(param)
    self.page.run_task(do_work)
```

### Loading data on mount
```python
class MyView(ft.Container):
    def did_mount(self):
        self.page.run_task(self._load_data)

    async def _load_data(self):
        data = await fetch_data()
        self._update_ui(data)
        self.update()
```

## Layout Patterns

### Responsive Column with Scroll
```python
ft.Column(
    controls=[...],
    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
    alignment=ft.MainAxisAlignment.START,
    scroll=ft.ScrollMode.AUTO,
    expand=True,
)
```

### Row with Spacing
```python
ft.Row(
    controls=[...],
    alignment=ft.MainAxisAlignment.CENTER,
    spacing=20,
    wrap=True,  # Wrap to next line if needed
    run_spacing=10,  # Spacing between wrapped lines
)
```

### Container with Shadow and Alignment
```python
ft.Container(
    content=...,
    width=400,
    height=300,
    bgcolor=ft.Colors.WHITE,
    border_radius=16,
    padding=32,
    alignment=ft.Alignment.CENTER,  # NOT ft.alignment.center
    shadow=ft.BoxShadow(
        spread_radius=1,
        blur_radius=15,
        color=ft.Colors.with_opacity(0.2, ft.Colors.BLACK),
        offset=ft.Offset(0, 4),
    ),
)
```

### Alignment Constants
```python
ft.Alignment.CENTER       # (0, 0)
ft.Alignment.TOP_LEFT     # (-1, -1)
ft.Alignment.TOP_CENTER   # (0, -1)
ft.Alignment.TOP_RIGHT    # (1, -1)
ft.Alignment.CENTER_LEFT  # (-1, 0)
ft.Alignment.CENTER_RIGHT # (1, 0)
ft.Alignment.BOTTOM_LEFT  # (-1, 1)
ft.Alignment.BOTTOM_CENTER# (0, 1)
ft.Alignment.BOTTOM_RIGHT # (1, 1)
```

## Page Configuration

```python
async def main(page: ft.Page):
    page.title = "App Title"
    page.theme_mode = ft.ThemeMode.LIGHT  # or DARK, SYSTEM
    page.window.width = 900
    page.window.height = 700
    page.window.min_width = 600
    page.window.min_height = 500
    page.padding = 0
    page.bgcolor = ft.Colors.GREY_100
```

## Snackbar Notifications

```python
def _show_message(self, message: str, error: bool = False):
    self.page.snack_bar = ft.SnackBar(
        content=ft.Text(message),
        bgcolor=ft.Colors.RED_700 if error else ft.Colors.GREEN_700,
    )
    self.page.snack_bar.open = True
    self.page.update()
```

## Navigation Pattern

```python
async def main(page: ft.Page):
    content_area = ft.Container(expand=True)

    def navigate_to(view_name: str, **kwargs):
        if view_name == "home":
            content_area.content = HomeView(
                on_navigate=lambda v, **k: navigate_to(v, **k)
            )
        elif view_name == "detail":
            content_area.content = DetailView(
                item_id=kwargs.get("item_id"),
                on_back=lambda: navigate_to("home"),
            )
        page.update()

    navigate_to("home")
    page.add(content_area)
```

## Common Pitfalls

1. **Don't use `ft.app()`** - Use `ft.run(main)` instead (0.80+)
2. **Don't inherit from `UserControl`** - Inherit from specific controls
3. **Dropdown uses `on_select`** - Not `on_change`
4. **Chip `on_select` auto-toggles** - Don't manually toggle in handler
5. **Always call `self.update()`** - After modifying control properties
6. **Use `page.run_task()`** - For async operations from sync handlers
7. **Button uses `content`** - Not `text` (use `content=ft.Text("label")`)
8. **Alignment uses class constants** - `ft.Alignment.CENTER` not `ft.alignment.center`
9. **run_task needs coroutine function** - NOT `lambda: coro()`, use inline `async def`

## Colors Reference

```python
ft.Colors.BLUE_700
ft.Colors.GREEN_600
ft.Colors.RED_400
ft.Colors.GREY_100
ft.Colors.WHITE
ft.Colors.with_opacity(0.5, ft.Colors.BLACK)
```

## Icons Reference

```python
ft.Icons.ADD
ft.Icons.DELETE
ft.Icons.EDIT
ft.Icons.SEARCH
ft.Icons.ARROW_BACK
ft.Icons.HOME
ft.Icons.PLAY_ARROW
ft.Icons.CHECK
ft.Icons.CLOSE
ft.Icons.INFO_OUTLINE
ft.Icons.ERROR_OUTLINE
ft.Icons.CELEBRATION
```

## Sources

- [Flet Documentation](https://flet.dev/docs/)
- [Flet Controls Reference](https://flet.dev/docs/controls)
- [Dropdown Control](https://flet.dev/docs/controls/dropdown)
- [Chip Control](https://flet.dev/docs/controls/chip)
- [TextField Control](https://flet.dev/docs/controls/textfield)
- [UserControl Migration Discussion](https://github.com/flet-dev/flet/discussions/3027)
