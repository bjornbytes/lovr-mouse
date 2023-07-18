lovr-mouse
===

A mouse module for LÖVR.

Usage
---

Copy `lovr-mouse.lua` to your project and require it.  I like to put it on the `lovr` global like this:

```lua
lovr.mouse = require 'lovr-mouse'

function lovr.update(dt)
  print(lovr.mouse.getPosition())
end
```

lovr-mouse can only run on systems where LÖVR uses both LuaJIT and GLFW. If your project needs to be compatible with Android or WebVR, you can optionally include lovr-mouse with:

```lua
if type(jit) == 'table' and lovr.getOS() ~= 'Android' and lovr.getOS() ~= 'Web' then
  lovr.mouse = require 'lovr-mouse'
end
```

Note that `lovr.mouse.setRelativeMode` will conflict with the mouselook behavior of the VR simulator.  To fix it, add this to `conf.lua` to disable the headset module:

```lua
function lovr.conf(t)
  t.modules.headset = false
end
```

API
---

- `mouse.getX()` Returns the x position of the cursor.
- `mouse.getY()` Returns the y position of the cursor.
- `mouse.getPosition()` Returns the x and y position of the cursor.
- `mouse.setX(x)` Sets the x position of the cursor.
- `mouse.setY(y)` Sets the y position of the cursor.
- `mouse.setPosition(x, y)` Sets the position of the cursor.
- `mouse.isDown(button, ...)` Returns whether any of the specified buttons are currently pressed.
  Available buttons:
  - `1` the left mouse button.
  - `2` the right mouse button.
  - `3` the middle mouse button.
  - Other higher numbers may be supported for fancier mice.
- `mouse.setRelativeMode(enable)` Sets or disables relative mode.  In relative mode the cursor is
  hidden and it can move infinitely (you can use the dx and dy parameters of mousemoved to get the
  movement amounts).
- `mouse.getRelativeMode()` Returns whether relative mode is currently enabled.
- `lovr.mousepressed(x, y, button)` Called when a mouse button is pressed.
- `lovr.mousereleased(x, y, button)` Called when a mouse button is released.
- `lovr.mousemoved(x, y, dx, dy)` Called when the mouse is moved.  The arguments represent the new
  cursor position as well as the delta from the previous position, in window coordinates.
- `lovr.wheelmoved(dx, dy)` Called when the mouse is scrolled.

License
---

MIT
