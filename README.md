lovr-mouse
===

A mouse module for LÖVR.

Usage
---

Copy `lovr-mouse.lua` to your project and require it.  I like to put it on the `lovr` global so
I can treat it like any other module:

```lua
lovr.mouse = require 'lovr-mouse'

function lovr.update(dt)
  print(lovr.mouse.getPosition())
end
```

API
---

- `mouse.getX()` Returns the x position of the cursor.
- `mouse.getY()` Returns the y position of the cursor.
- `mouse.getPosition()` Returns the x and y position of the cursor.
- `mouse.isDown(button, ...)` Returns whether any of the specified buttons are currently pressed.
  Available buttons:
  - `1` the left mouse button.
  - `2` the right mouse button.
  - `3` the middle mouse button.
  - Other higher numbers may be supported for fancier mice.
- `lovr.mousepressed(x, y, button)` Called when a mouse button is pressed.
- `lovr.mousereleased(x, y, button)` Called when a mouse button is released.
- `lovr.mousemoved(x, y, dx, dy)` Called when the mouse is moved.  The arguments represent the new
  cursor position as well as the delta from the previous position, in window coordinates.
- `lovr.wheelmoved(dx, dy)` Called when the mouse is scrolled.

License
---

MIT
